#!/bin/sh

mkdir -p /opt/grafana/data/plugins/

find /app ! -user daemon -exec chown daemon:daemon {} \; &
find /tmp ! -user daemon -exec chown daemon:daemon {} \; &
find /opt/grafana/data ! -user daemon -exec chown daemon:daemon {} \; &

sudo -u daemon -g daemon /opt/grafana/bin/grafana-server \
	-homepath /opt/grafana \
	-config /app/grafana.ini
