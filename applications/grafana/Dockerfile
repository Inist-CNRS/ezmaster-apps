FROM debian:bullseye-slim

WORKDIR /opt/grafana
RUN apt-get update && \
	apt-get install -y wget tini sudo && \
	rm -rf /var/lib/apt/lists/* && \
	wget  https://dl.grafana.com/grafana/release/12.2.0/grafana_12.2.0_17949786146_linux_amd64.tar.gz && \
	tar -zxvf "grafana_12.2.0_17949786146_linux_amd64.tar.gz" --strip-components=1 --no-same-owner && \
	rm -f grafana_12.2.0_17949786146_linux_amd64.tar.gz

WORKDIR /app
ADD grafana.ini /app/

RUN echo '{ \
  "httpPort": 3000, \
  "configPath": "/app/grafana.ini", \
  "configType": "txt", \
  "dataPath": "/app/grafana", \
  "technicalApplication": true \
}' > /etc/ezmaster.json && \
mkdir -p /app/grafana/data


EXPOSE 3000
ADD docker-entrypoint.sh /
ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD [ "/docker-entrypoint.sh" ]
