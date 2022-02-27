# ezmaster-apps

Monorepo for ezmaster applications configurations.


## How to ...

### build an application

```bash
lerna exec npm run build --scope=lodex-workers-saxon
```

### start an application

```bash
lerna exec npm start --scope=lodex-workers-saxon
```


### generate un new version (ans push in docker hub)

```bash
cd ./applications/lodex-workers-saxon/
npm version patch|minor|major

```
