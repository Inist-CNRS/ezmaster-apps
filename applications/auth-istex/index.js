const express      = require('express');
const axios        = require('axios');
const cookieParser = require('cookie-parser');
const { target, source, secure } = require('./config.json');
const app          = express();

app.use(cookieParser());

const AUTH_URL = target;
const PUBLIC_HOST = source;

// --- Route de login : redirige vers authFede sans passer par forwardAuth ---
app.get('/auth/login', (req, res) => {
  const host       = PUBLIC_HOST || req.headers['x-forwarded-host'] || req.hostname;
  const callbackUrl = `${host}/auth/callback`;
  res.redirect(`${AUTH_URL}/?target=${encodeURIComponent(callbackUrl)}`);
});

// --- Route de callback : reçoit le cookie en paramètre, le pose et redirige vers / ---
app.get('/auth/callback', (req, res) => {
  const host       = PUBLIC_HOST || req.headers['x-forwarded-host'] || req.hostname;
  const cookieValue = req.query.cookie;
  const cookieName  = req.query.name || '_shibsession';

  if (!cookieValue) {
    return res.status(400).send('Missing cookie parameter');
  }

  res.cookie(cookieName, cookieValue, {
    httpOnly: true,
    secure,
    sameSite: 'Lax',
  });

  res.redirect(host);
});

// --- Route de vérification : appelée par forwardAuth à chaque requête ---
app.get('/auth/check', async (req, res) => {
  try {
    const response = await axios.get(`${AUTH_URL}/`, {
      headers: {
        // Transmet le cookie Shibboleth posé par authFede
        'Cookie':          req.headers['cookie']          || '',
        'X-Forwarded-For': req.headers['x-forwarded-for'] || req.ip,
      },
      maxRedirects: 0,
      validateStatus: () => true,
    });

    if (response.status >= 200 && response.status < 300) {
      const data = response.data;

      res.set('X-Remote-User',  data._id          || '');
      res.set('X-Email',        data._email        || '');
      res.set('X-Display-Name', data._displayName  || '');
      res.set('X-First-Name',   data._firstName    || '');
      res.set('X-Last-Name',    data._lastName     || '');
      res.set('X-Institution',  data._institution  || '');
      res.set('X-Organisation', data._o            || '');
      res.set('X-Ou',           data._ou           || '');
      res.set('X-Eppn',         data._eppn         || '');
      res.set('X-Affiliation',  data._affiliation  || '');

      res.sendStatus(200);

    } else {
      // Pas de session Shibboleth → on indique où s'authentifier
      res.set('X-Auth-Login-URL', '/auth/login');
      res.sendStatus(401);
    }

  } catch (err) {
    console.error('Auth check error:', err.message);
    res.sendStatus(503);
  }
});

app.listen(3003, () => console.log('auth-proxy listening on :3003'));
