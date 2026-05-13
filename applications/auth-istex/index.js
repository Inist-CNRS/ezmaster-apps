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
  const redirect = `${AUTH_URL}/?target=${encodeURIComponent(callbackUrl)}`;
  console.error(`/auth/login vers ${redirect}`)
  res.redirect(302, redirect);
});

// --- Route de callback : reçoit le cookie en paramètre, le pose et redirige vers / ---
app.get('/auth/callback', (req, res) => {
  const host       = PUBLIC_HOST || req.headers['x-forwarded-host'] || req.hostname;
  const cookieRaw = req.query.cookie;
  const [ cookieName, cookieValue] = String(cookieRaw).split('=');

  if (!cookieValue) {
    console.error(`/auth/callback is KO`);
    return res.status(400).send('Missing cookie parameter');
  }

  res.cookie(cookieName, cookieValue, {
    httpOnly: true,
    secure,
    sameSite: 'Lax',
  });
  const redirect = `${host}/`;
  console.error(`/auth/callback vers ${redirect}`);
  res.redirect(302, redirect);
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

      console.error(`/auth/check is OK`);
      res.sendStatus(200);

    } else {
      // Pas de session Shibboleth → on indique où s'authentifier
      res.set('X-Auth-Login-URL', '/auth/login');
      console.error(`/auth/check is KO`);
      res.sendStatus(401);
    }

  } catch (err) {
    console.error('Auth check error:', err.message);
    res.sendStatus(503);
  }
});

app.listen(3003, () => console.log('auth-proxy listening on :3003'));
