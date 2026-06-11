#!/bin/bash

chown -R mongod:mongod /ezdata/db

# basic http server for displaing a basic informative html page for ezmaster
cd /www && su-exec mongod:mongod python3 -m http.server 3000 &

# start mongodb daemon
su-exec mongod:mongod python3 /usr/local/bin/docker-entrypoint.py $@
