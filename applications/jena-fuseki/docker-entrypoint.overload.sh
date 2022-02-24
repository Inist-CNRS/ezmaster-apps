#!/bin/bash

grep "admin=" /fuseki/shiro.ini | sed  "s/^admin=/# For information : Server access login\/password = admin\//"

#echo "Update Fuseki configuration..."
#cp -f /config.ttl /fuseki/

./load.sh

sleep 2

exec /docker-entrypoint.sh $@
