#!/bin/sh

find /app ! -user daemon -exec chown daemon:daemon {} \; &
find /tmp ! -user daemon -exec chown daemon:daemon {} \; &

cat /app/prometheus.global.yml /app/data/config/*.yml /app/data/config/*.yaml > /app/prometheus.yml 2>/dev/null
/reload-config.sh &

sudo -u daemon -g daemon /opt/prometheus/prometheus \
	--config.file=/app/prometheus.yml \
	--web.enable-lifecycle \
	--storage.tsdb.path=/app/data/prometheus \
	--storage.tsdb.retention.time=3m
