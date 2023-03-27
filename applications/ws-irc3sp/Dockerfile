FROM inistcnrs/lodex-workers:9.2.3

WORKDIR /app/public
COPY ./public/ /app/public/

WORKDIR /app
COPY ./docker-entrypoint.sh ./config.json ./package-app.json /app/

RUN apk add --update-cache --no-cache \
	build-base \
	cmake \
	openssl-dev \
	perl \
	perl-json \
	&& \
	gunzip public/v1/CoL.txt.gz && \
	mv package-app.json package.json && \
	npm install --production && \
	npm cache clean --force && \
	npm prune --production && \
	echo '{ \
	"httpPort": 31976, \
	"configPath": "/app/config.json", \
	"dataPath": "/app/public" \
	}' > /etc/ezmaster.json && \
	sed -i -e "s/daemon:x:2:2/daemon:x:1:1/" /etc/passwd && \
	sed -i -e "s/daemon:x:2:/daemon:x:1:/" /etc/group && \
	sed -i -e "s/bin:x:1:1/bin:x:2:2/" /etc/passwd && \
	sed -i -e "s/bin:x:1:/bin:x:2:/" /etc/group && \
	mkdir -p /sbin/.npm /sbin/.config /sbin/.local && \
	chown -R daemon:daemon /app /tmp /sbin/.npm /sbin/.config /sbin/.local

ENV LANG C.UTF-8

EXPOSE 31976

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD [ "/app/docker-entrypoint.sh" ]
