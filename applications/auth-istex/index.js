const express      = require('express');
const axios        = require('axios');
const cookieParser = require('cookie-parser');
const { target } = require('./config.json');
const app          = express();

app.use(cookieParser());

const AUTH_URL = target;

// --- Route de login : redirige vers authFede sans passer par forwardAuth ---
app.get('/auth/login', (req, res) => {
  const redirectTo = req.query.redirect || '/';
  // Redirige directement vers authFede qui va gérer le flux Shibboleth
  // et poser son cookie de session
  res.redirect(`${AUTH_URL}?redirect=${encodeURIComponent(redirectTo)}`);
});

// --- Route de vérification : appelée par forwardAuth à chaque requête ---
app.get('/auth/check', async (req, res) => {
  try {
    const response = await axios.get(AUTH_URL, {
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
      if (!data._id) return res.sendStatus(401);

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
