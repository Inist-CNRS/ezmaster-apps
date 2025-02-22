#!/bin/bash

chown -R mongod:mongod /ezdata/db
chown -R mongod:mongod /ezdata/dump

# initialize data flags used by inherited docker-entrypoint.sh
#test ! -f /ezdata/db/WiredTiger && rm -f /data/db/WiredTiger
#test   -f /ezdata/db/WiredTiger && ln -s /ezdata/db/WiredTiger /data/db/
#test ! -f /ezdata/db/docker-initdb.log && rm -f /data/db/docker-initdb.log
#test   -f /ezdata/db/docker-initdb.log && ln -s /ezdata/db/docker-initdb.log /data/db/
su-exec mongod:mongod touch /ezdata/db/TEST

# inject config.json parameters to env
# only if not already defined in env
export DUMP_EACH_NBHOURS=${DUMP_EACH_NBHOURS:=$(jq -r -M .DUMP_EACH_NBHOURS /config.json | grep -v null)}
export DUMP_CLEANUP_MORE_THAN_NBDAYS=${DUMP_CLEANUP_MORE_THAN_NBDAYS:=$(jq -r -M .DUMP_CLEANUP_MORE_THAN_NBDAYS /config.json | grep -v null)}

# backup/dump stuff
su-exec mongod:mongod dump.periodically.sh &

# basic http server for displaing a basic informative html page for ezmaster
cd /www && su-exec mongod:mongod python3 -m http.server 3000 &

# start mongodb daemon
su-exec mongod:mongod python3 /usr/local/bin/docker-entrypoint.py $@
