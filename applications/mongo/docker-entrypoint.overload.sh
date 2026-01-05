#!/bin/bash

chown -R mongod:mongod /ezdata/db

# initialize data flags used by inherited docker-entrypoint.sh
#test ! -f /ezdata/db/WiredTiger && rm -f /data/db/WiredTiger
#test   -f /ezdata/db/WiredTiger && ln -s /ezdata/db/WiredTiger /data/db/
#test ! -f /ezdata/db/docker-initdb.log && rm -f /data/db/docker-initdb.log
#test   -f /ezdata/db/docker-initdb.log && ln -s /ezdata/db/docker-initdb.log /data/db/
su-exec mongod:mongod touch /ezdata/db/TEST

# basic http server for displaing a basic informative html page for ezmaster
cd /www && su-exec mongod:mongod python3 -m http.server 3000 &

# start mongodb daemon
su-exec mongod:mongod python3 /usr/local/bin/docker-entrypoint.py $@
