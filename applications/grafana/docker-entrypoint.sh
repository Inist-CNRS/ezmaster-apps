#!/bin/sh

find /app ! -user daemon -exec chown daemon:daemon {} \; &
find /tmp ! -user daemon -exec chown daemon:daemon {} \; &

sudo -u daemon -g daemon /opt/grafana/bin/grafana-server \
	-homepath /opt/grafana \
	-config /app/grafana.ini
