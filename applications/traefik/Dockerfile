FROM traefik:2.10
COPY traefik.yml /etc/traefik/traefik.yml
EXPOSE 3000
RUN echo '{ \
  "httpPort": 3000, \
  "configPath": "/etc/traefik/traefik.conf", \
  "configType": "text", \
  "dataPath":   "/dynamic/config", \
  "technicalApplication": true \
}' > /etc/ezmaster.json && \
	mkdir -p /www && \
	mkdir -p /dynamic/config
