FROM inistcnrs/lodex-workers-python:4.0.11 AS app
FROM bitnami/pytorch:1.10.2
COPY --from=app /app /app
WORKDIR /app
USER root
ENV NODE_VERSION 14.19.0
ENV ARCH x64
RUN  set -ex; \
     \
     curl -o /usr/local/bin/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c; \
     \
     fetch_deps='gcc libc-dev'; \
     apt-get update; \
     apt-get install -y --no-install-recommends $fetch_deps; \
     rm -rf /var/lib/apt/lists/*; \
     gcc -Wall \
         /usr/local/bin/su-exec.c -o/usr/local/bin/su-exec; \
     chown root:root /usr/local/bin/su-exec; \
     chmod 0755 /usr/local/bin/su-exec; \
     rm /usr/local/bin/su-exec.c; \
     \
     apt-get purge -y --auto-remove $fetch_deps
RUN apt-get update && \
	apt-get install xz-utils sudo tini build-essential git musl-dev unzip -y  && \
	curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" && \
	curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt" && \
	grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c - && \
	tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner && \
	rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt && \
	ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
	node --version && \
	npm --version && \
	npm install --production && \
	npm cache clean --force && \
	npm prune --production && \
	echo '{ \
      "httpPort": 31976, \
      "configPath": "/app/config.json", \
      "dataPath": "/app/public" \
    }' > /etc/ezmaster.json && \
	mkdir -p /.npm /.config /.cache && \
	chown -R daemon:daemon /app /.npm /.config /.cache && \
    ln -s /usr/lib/x86_64-linux-musl/libc.so /lib/libc.musl-x86_64.so.1 && \
	sed -i 's/su-exec daemon:daemon/sudo -u daemon -g daemon/g' ./docker-entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD [ "/app/docker-entrypoint.sh" ]
