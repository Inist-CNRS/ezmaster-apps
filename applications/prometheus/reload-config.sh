#!/bin/sh

while true
do
		inotifywait -qr -e modify -e create -e delete -e move --exclude '/\.' /app/data/config;
		cat /app/prometheus.global.yml /app/data/config/*.yml /app/data/config/*.yml > /app/prometheus.yml 2>/dev/null
		curl -s -X POST localhost:9090/-/reload
done
