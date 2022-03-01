# ezmaster-web-term

[![Docker Pulls](https://img.shields.io/docker/pulls/inistcnrs/ezmaster-web-term.svg)](https://registry.hub.docker.com/u/inistcnrs/ezmaster-web-term/)

Web terminal used for debugging [ezmaster](https://github.com/Inist-CNRS/ezmaster) stuff.

Warning: do not uses it for something else than debugging or cleaning things and uses it at your own risk. Be aware that if ezmaster is configured with the ``EZMASTER_PUBLIC_DOMAIN`` enabled instances will be available on the Internet so **you NEED to setup a strong password**.  

[![web-term](https://camo.githubusercontent.com/2fc5855095b5f47da0875c9fd779ada2e39a6f81/687474703a2f2f692e696d6775722e636f6d2f336b4d4a6876632e706e67)](https://github.com/IonicaBizau/web-term/)

## Usage

- Add the application in your [ezmaster](https://github.com/Inist-CNRS/ezmaster) ([inistcnrs/ezmaster-web-term:1.0.2](https://hub.docker.com/r/inistcnrs/ezmaster-web-term/tags/)) then create a new instance
- Create a new instance
- Open the created instance ezmaster config and change the login/password at the end of the config (default is admin/ezmaster)
- Open the instance web url and you will have a fullscreen terminal connected on the created instance shell
- Thanks to this shell, you can then connect to the `ezmaster_db` database

### Usage for ezmaster's mongodb cleanup


This use case is to cleanup old ezvis databases stored in the mongo ``ezmaster_db`` database :

```shell
apt update
apt install mongodb-clients
mongo --host ezmaster_db

> show databases
...
> use my-ezvis-1;
> db.dropDatabase();
```

## Developer

To run stuff locally, just type:

```
make build
docker run -it --name ezmaster-web-term --rm -p 8080:80 inistcnrs/ezmaster-web-term:1.0.2
```

Then open your browser on http://localhost:8080
