# ezmaster-apps

Monorepo for ezmaster applications configurations :

- [jena-fuseki](./jena-fuseki/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/jena-fuseki.svg)](https://registry.hub.docker.com/u/inistcnrs/jena-fuseki/)
- [lodex-theme-daf](./lodex-theme-daf/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-theme-daf.svg)](https://registry.hub.docker.com/u/inistcnrs/lodex-theme-daf/)
- [lodex-theme-istex](./lodex-theme-istex/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-theme-istex.svg)](https://registry.hub.docker.com/u/inistcnrs/lodex-theme-istex/)
- [lodex-workers](./lodex-workers/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-workers.svg)](https://registry.hub.docker.com/u/inistcnrs/lodex-workers/)
- [lodex-workers-libpostal](./lodex-workers-libpostal/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-workers-libpostal.svg)](https://registry.hub.docker.com/u/inistcnrs/lodex-workers-libpostal/)
- [lodex-workers-python](./lodex-workers-python/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-workers-python.svg)](https://registry.hub.docker.com/u/inistcnrs/lodex-workers-python/)
- [lodex-workers-pytorch](./lodex-workers-pytorch/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-workers-pytorch.svg)](https://registry.hub.docker.com/u/inistcnrs/lodex-workers-pytorch/)
- [lodex-workers-saxon](./lodex-workers-saxon/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-workers-saxon.svg)](https://registry.hub.docker.com/u/inistcnrs/lodex-workers-saxon/)
- [mongo](./mongo/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-mongo.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-mongo/)
- [monitoring](./monitoring/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-monitoring.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-monitoring/)
- [mysql](./mysql/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-mysql.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-mysql/)
- [nginx](./nginx/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-nginx.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-nginx/)
- [phpserver](./phpserver/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-phpserver.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-phpserver/)
- [proxy](./proxy/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-proxy.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-proxy/)
- [virtuoso](./virtuoso/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-virtuoso.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-virtuoso/)
- [webserver](./webserver/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-webserver.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-webserver/)
- [web-term](./web-term/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-web-term.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-web-term/)


## How to ...

### build an application

```bash
lerna exec npm run build --scope=lodex-workers-saxon
```

### start an application

```bash
lerna exec npm start --scope=lodex-workers-saxon
```

### generate a new application version (and push it in docker hub)

```bash
cd ./applications/lodex-workers-saxon/
npm version patch|minor|major

```
