#!/bin/sh

find /app ! -user daemon -exec chown daemon:daemon {} \; &
find /tmp ! -user daemon -exec chown daemon:daemon {} \; &

cd /app/www && python -m SimpleHTTPServer 3000 &

sudo -u daemon -g daemon /opt/prometheus/prometheus \
	--config.file=/app/prometheus.yml \
	--storage.tsdb.path=/app/prometheus
