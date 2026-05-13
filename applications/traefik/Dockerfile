FROM traefik:2.10
COPY traefik.yml /etc/traefik/traefik.yml
ENV HTTP_PROXY=""
ENV HTTPS_PROXY=""
ENV http_proxy=""
ENV https_proxy=""
ENV NO_PROXY=""
ENV no_proxy=""
EXPOSE 3000
RUN echo '{ \
  "httpPort": 3000, \
  "configPath": "/etc/traefik/traefik.yml", \
  "configType": "text", \
  "dataPath":   "/dynamic/config", \
  "technicalApplication": true \
}' > /etc/ezmaster.json && \
	mkdir -p /www && \
	mkdir -p /dynamic/config
