FROM debian:bullseye-slim

WORKDIR /opt/prometheus
RUN apt-get update && \
	apt-get install -y wget tini sudo && \
	rm -rf /var/lib/apt/lists/* && \
	wget https://github.com/prometheus/prometheus/releases/download/v2.33.4/prometheus-2.33.4.linux-amd64.tar.gz && \
	tar -zxvf "prometheus-2.33.4.linux-amd64.tar.gz" --strip-components=1 --no-same-owner && \
	rm -f prometheus-2.33.4.linux-amd64.tar.gz

WORKDIR /opt/grafana
RUN wget https://dl.grafana.com/oss/release/grafana-8.4.2.linux-amd64.tar.gz && \
	tar -zxvf "grafana-8.4.2.linux-amd64.tar.gz" --strip-components=1 --no-same-owner && \
	rm -f grafana-8.4.2.linux-amd64.tar.gz

WORKDIR /app
ADD prometheus.yml /app/
ADD grafana.ini /app/

RUN echo '{ \
  "httpPort": 3000, \
  "configPath": "/app/prometheus.yml", \
  "configType": "txt", \
  "dataPath": "/app/prometheus", \
  "technicalApplication": true \
}' > /etc/ezmaster.json && \
mkdir -p /app/prometheus && \
mkdir -p /app/grafana/data


EXPOSE 3000
ADD docker-entrypoint.sh /
ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD [ "/docker-entrypoint.sh" ]
