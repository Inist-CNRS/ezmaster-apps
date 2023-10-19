# ezmaster-apps

Monorepo for ezmaster applications configurations :

- [grafana](./applications/grafana/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-grafana.svg)](https://registry.hub.docker.com/r/inistcnrs/ezmaster-grafana/)
- [jena-fuseki](./applications/jena-fuseki/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-jena-fuseki.svg)](https://registry.hub.docker.com/r/inistcnrs/ezmaster-jena-fuseki/)
- [lodex-theme-daf](./applications/lodex-theme-daf/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-theme-daf.svg)](https://registry.hub.docker.com/r/inistcnrs/lodex-theme-daf/)
- [lodex-theme-istex](./applications/lodex-theme-istex/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-theme-istex.svg)](https://registry.hub.docker.com/r/inistcnrs/lodex-theme-istex/)
- [lodex-workers](./applications/lodex-workers/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-workers.svg)](https://registry.hub.docker.com/r/inistcnrs/lodex-workers/)
- [lodex-workers-libpostal](./applications/lodex-workers-libpostal/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-libpostal.svg)](https://registry.hub.docker.com/r/inistcnrs/ezmaster-libpostal/)
- [lodex-workers-python](./applications/lodex-workers-python/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-workers-python.svg)](https://registry.hub.docker.com/r/inistcnrs/lodex-workers-python/)
- [lodex-workers-pytorch](./applications/lodex-workers-pytorch/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-workers-pytorch.svg)](https://registry.hub.docker.com/r/inistcnrs/lodex-workers-pytorch/)
- [lodex-workers-saxon](./applications/lodex-workers-saxon/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-workers-saxon.svg)](https://registry.hub.docker.com/r/inistcnrs/lodex-workers-saxon/)
- [mongo](./applications/mongo/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-mongo.svg)](https://registry.hub.docker.com/r/inistcnrs/ezmaster-mongo/)
- [mysql](./applications/mysql/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-mysql.svg)](https://registry.hub.docker.com/r/inistcnrs/ezmaster-mysql/)
- [nginx](./applications/nginx/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-nginx.svg)](https://registry.hub.docker.com/r/inistcnrs/ezmaster-nginx/)
- [phpserver](./applications/phpserver/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-phpserver.svg)](https://registry.hub.docker.com/r/inistcnrs/ezmaster-phpserver/)
- [prometheus](./applications/prometheus/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-prometheus.svg)](https://registry.hub.docker.com/r/inistcnrs/ezmaster-prometheus/)
- [proxy](./applications/proxy/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-proxy.svg)](https://registry.hub.docker.com/r/inistcnrs/ezmaster-proxy/)
- [virtuoso](./applications/virtuoso/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-virtuoso.svg)](https://registry.hub.docker.com/r/inistcnrs/ezmaster-virtuoso/)
- [webserver](./applications/webserver/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-webserver.svg)](https://registry.hub.docker.com/r/inistcnrs/ezmaster-webserver/)
- [web-term](./applications/web-term/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-web-term.svg)](https://registry.hub.docker.com/r/inistcnrs/ezmaster-web-term/)
- [ws-affiliation-rnsr](./applications/ws-affiliation-rnsr/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ws-affiliation-rnsr.svg)](https://registry.hub.docker.com/r/inistcnrs/ws-affiliation-rnsr/)
- [ws-astro-ner](./applications/ws-astro-ner/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ws-astro-ner.svg)](https://registry.hub.docker.com/r/inistcnrs/ws-astro-ner/)
- [ws-irc3sp](./applications/ws-irc3sp/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ws-irc3sp.svg)](https://registry.hub.docker.com/r/inistcnrs/ws-irc3sp/)

## How to

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
