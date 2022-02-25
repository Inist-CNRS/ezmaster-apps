#!/bin/sh

find /app ! -user daemon -exec chown daemon:daemon {} \;
chown daemon:daemon /tmp

sudo -u daemon -g daemon /opt/prometheus/prometheus --config.file=/app/prometheus.yml --storage.tsdb.path=/app/prometheus &

sudo -u daemon -g daemon /opt/grafana/bin/grafana-server -homepath /opt/grafana -config /app/grafana.ini
