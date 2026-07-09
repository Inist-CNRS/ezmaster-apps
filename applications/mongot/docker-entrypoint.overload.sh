#!/bin/bash

set -e

chmod 1777 /tmp

/usr/local/bin/init-mongo.sh &

# start mongot daemon
exec sh -c '/usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf'
