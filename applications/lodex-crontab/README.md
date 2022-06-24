# ezmaster-webserver

[![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-webserver.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-webserver/)

Web Server for [ezmaster](https://github.com/Inist-CNRS/ezmaster)

## Prerequisites

[ezmaster](https://github.com/Inist-CNRS/ezmaster) ⩾ [3.8.0](https://github.com/Inist-CNRS/ezmaster#ezmaster-380)

## Usage

- Add the application in your [ezmaster](https://github.com/Inist-CNRS/ezmaster) ([inistcnrs/ezmaster-webserver:5.1.3](https://hub.docker.com/r/inistcnrs/ezmaster-webserver/tags/)) then create a new instance
- To configure your web server
- To serve content, just upload your files into `/www`

### Crontab feature

To sync with git repo, just change the config :

```json
{
 "environnement": {
        "NODE_ENV": "production",
        "CRON_VERBOSE": true,
        "GIT_REPOSITORY": "https://github.com/Inist-CNRS/lodex-extented",
        "GIT_BRANCH": "v3"
    },
 "tasks": [
        {
            "when": "30 * * * *",
            "execute": "/app/gitsync $GIT_REPOSITORY $GIT_BRANCH"
        }
    ]
}
```

To sync with a directory within a monorepo, use:

```json
{
 "environnement": {
        "NODE_ENV": "production",
        "CRON_VERBOSE": true,
        "GIT_REPOSITORY": "https://gitbucket.inist.fr/git/tdm/web-services.git",
        "GIT_BRANCH": "master",
        "GIT_DIRECTORY": "www-home"
    },
    "tasks": [{
      "when": "30 8-19 * * 1-5",
      "execute": "/app/gitsyncdir $GIT_REPOSITORY $GIT_BRANCH $GIT_DIRECTORY "
    }]
}
```

> **Tip**: use <https://crontab.guru/> to check the `when` of your tasks.

### Authentication feature

To enable autentication, just edit this line with the wanted login/password in the config:

```json
{
    "options": {
        "authUser": "admin",
        "authPass": "secret"
    }
}
```

### Redirect feature

Re-route path using regex, just add rules with from/to key in the config:

```json
{
    "options" : {
        "rewrite": [
          {
            "from": "/(.*)",
            "to": "https://user-doc.lodex.inist.fr/$1"
          }
        ]
    }
}
```

### Advanced Configuration

```json
{
    "options": {
        "logFormat": "combined"
    }
}
```

## Developer

To run stuff locally, just type:

```bash
make build
make run-debug
```

Then open your browser at <http://localhost:8000>
