#!/bin/sh
node /usr/local/lib/server.js &
exec /usr/local/bin/docker-entrypoint.sh $@
