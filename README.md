# ezmaster-apps

Monorepo for ezmaster applications configurations :

- [grafana](./applications/grafana/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-grafana.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-grafana/)
- [jena-fuseki](./applications/jena-fuseki/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-jena-fuseki.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-jena-fuseki/)
- [lodex-theme-daf](./applications/lodex-theme-daf/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-theme-daf.svg)](https://registry.hub.docker.com/u/inistcnrs/lodex-theme-daf/)
- [lodex-theme-istex](./applications/lodex-theme-istex/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-theme-istex.svg)](https://registry.hub.docker.com/u/inistcnrs/lodex-theme-istex/)
- [lodex-workers](./applications/lodex-workers/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-workers.svg)](https://registry.hub.docker.com/u/inistcnrs/lodex-workers/)
- [lodex-workers-libpostal](./applications/lodex-workers-libpostal/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-libpostal.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-libpostal/)
- [lodex-workers-python](./applications/lodex-workers-python/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-workers-python.svg)](https://registry.hub.docker.com/u/inistcnrs/lodex-workers-python/)
- [lodex-workers-pytorch](./applications/lodex-workers-pytorch/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-workers-pytorch.svg)](https://registry.hub.docker.com/u/inistcnrs/lodex-workers-pytorch/)
- [lodex-workers-saxon](./applications/lodex-workers-saxon/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/lodex-workers-saxon.svg)](https://registry.hub.docker.com/u/inistcnrs/lodex-workers-saxon/)
- [mongo](./applications/mongo/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-mongo.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-mongo/)
- [mysql](./applications/mysql/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-mysql.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-mysql/)
- [nginx](./applications/nginx/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-nginx.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-nginx/)
- [phpserver](./applications/phpserver/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-phpserver.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-phpserver/)
- [prometheus](./applications/prometheus/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-prometheus.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-phpserver/)
- [proxy](./applications/proxy/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-proxy.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-proxy/)
- [virtuoso](./applications/virtuoso/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-virtuoso.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-virtuoso/)
- [webserver](./applications/webserver/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-webserver.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-webserver/)
- [web-term](./applications/web-term/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-web-term.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-web-term/)
- [ws-affiliation-rnsr](./applications/ws-affiliation-rnsr/) [![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ws-affiliation-rnsr.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-web-term/)


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
