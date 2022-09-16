FROM node:16-alpine
WORKDIR /app
# see .dockerignore to know all copied files
COPY . /app/
RUN mv package-app.json package.json && \
	mkdir -p /app/public && \
    apk add --no-cache su-exec make gcc g++ python3 bash git openssh tini curl && \
    npm install --production && \
	npm cache clean --force && \
	npm prune --production && \
	echo '{ \
      "httpPort": 8000, \
      "configPath": "/app/config.json", \
      "dataPath": "/app/public" \
    }' > /etc/ezmaster.json && \
    sed -i -e "s/daemon:x:2:2/daemon:x:1:1/" /etc/passwd && \
    sed -i -e "s/daemon:x:2:/daemon:x:1:/" /etc/group && \
    sed -i -e "s/bin:x:1:1/bin:x:2:2/" /etc/passwd && \
    sed -i -e "s/bin:x:1:/bin:x:2:/" /etc/group && \
	mkdir -p /sbin/.npm /sbin/.config && \
	chown -R daemon:daemon /app /sbin/.npm /sbin/.config

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD [ "/app/docker-entrypoint.sh" ]
