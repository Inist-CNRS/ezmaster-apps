FROM nginx:1.13.3
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 3000 
RUN echo '{ \
  "httpPort": 3000, \
  "configPath": "/etc/nginx/nginx.conf", \
  "configType": "text", \
  "dataPath":   "/www" \
}' > /etc/ezmaster.json && \
	mkdir -p /www
