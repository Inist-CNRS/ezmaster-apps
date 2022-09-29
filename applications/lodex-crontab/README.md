# lodex-crontab

[![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-webserver.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-webserver/)

[ezs](https://inist-cnrs.github.io/ezs/#/?id=ezs) server and static web server for [ezmaster](https://github.com/Inist-CNRS/ezmaster)

## Prerequisites

[ezmaster](https://github.com/Inist-CNRS/ezmaster) ⩾ [3.8.0](https://github.com/Inist-CNRS/ezmaster#ezmaster-380)

## Usage

- Add the application in your [ezmaster](https://github.com/Inist-CNRS/ezmaster) ([inistcnrs/lodex-crontab:1.4.0](https://hub.docker.com/r/inistcnrs/lodex-crontab/tags/)) then create a new instance
- All your content is exposed to the web
- Upload your `.ini` scripts to the `public` repository (accessible via WebDav when using ezmastr)

### Crontab feature

To sync with git repo, just change the config :

```json
{
    "environnement": {
        "NODE_ENV": "production",
        "CRON_VERBOSE": true
    },
    "files" : {
        "zip": "https://gitbucket.inist.fr/tdm/web-dumps/archive/example/master.zip"
    },
    "tasks": [
    {
        "CronRule": "0 1 * * *",
        "FileName": "example",
        "RunOnStartup": true
    },
    {
        "CronRule": "0 1 * * *",
        "Target": "example",
        "RunOnStartup": true
    },
    {
        "CronRule": "0 1 * * *",
        "RunOnStartup": true
    }
    ]
}
```

> **Tip**: use <https://crontab.guru/> to check the `CronRule` of your tasks.
