FROM debian:bullseye-slim

WORKDIR /opt/prometheus
RUN apt-get update && \
	apt-get install -y wget tini sudo inotify-tools curl && \
	rm -rf /var/lib/apt/lists/* && \
	wget https://github.com/prometheus/prometheus/releases/download/v2.33.4/prometheus-2.33.4.linux-amd64.tar.gz && \
	tar -zxvf "prometheus-2.33.4.linux-amd64.tar.gz" --strip-components=1 --no-same-owner && \
	rm -f prometheus-2.33.4.linux-amd64.tar.gz

WORKDIR /app
ADD prometheus.yml /app/prometheus.global.yml
RUN echo '{ \
  "httpPort": 9090, \
  "configPath": "/app/prometheus.global.yml", \
  "configType": "txt", \
  "dataPath": "/app/data", \
  "technicalApplication": true \
}' > /etc/ezmaster.json && \
mkdir -p /app/data/prometheus && \
mkdir -p /app/data/config

EXPOSE 9000
EXPOSE 9090
ADD reload-config.sh /
ADD docker-entrypoint.sh /
ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD [ "/docker-entrypoint.sh" ]
