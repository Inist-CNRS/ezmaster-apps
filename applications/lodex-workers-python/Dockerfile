FROM inistcnrs/lodex-workers:9.2.1 AS build1
FROM golang:1.17.5-alpine3.15 as build2
# System setup
RUN apk update && \
	apk add git curl build-base autoconf automake libtool

# Install protoc
ENV PROTOBUF_URL https://github.com/google/protobuf/releases/download/v3.3.0/protobuf-cpp-3.3.0.tar.gz
WORKDIR /tmp/
RUN curl -L -o /tmp/protobuf.tar.gz $PROTOBUF_URL && \
	tar xvzf protobuf.tar.gz && \
	cd /tmp/protobuf-3.3.0 && \
	mkdir /export  && \
	./autogen.sh && \
    ./configure --prefix=/export && \
    make -j 3 && \
    make check && \
    make install

# Install protoc-gen-go
RUN go get github.com/golang/protobuf/protoc-gen-go  && \
	cp /go/bin/protoc-gen-go /export/bin/  && \
	cp /usr/lib/libstdc++* /export/lib/ && \
	cp /usr/lib/libgcc_s* /export/lib/

FROM node:14-alpine3.15 AS release
COPY --from=build1 /app /app
COPY --from=build2 /export /usr
WORKDIR /app
# see .dockerignore to know all copied files
COPY ./config.json ./package-app.json /app/
COPY ./public/requirements.txt ./public/expand.py ./public/expand.ini /app/public/
RUN apk add --update-cache --no-cache \
	su-exec \
	bash \
	git \
	openssh \
	build-base \
	cmake \
	python3 \
	python3-dev \
	py3-pip \
	libgfortran \
	lapack-dev \
	openssl-dev \
	libffi-dev \
	ghostscript-dev \
	openblas-dev \
	ca-certificates \
	rust \
	curl \
	tini \
	cargo \
	cython \
	&& \
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
	chown -R daemon:daemon /app /tmp /sbin/.npm /sbin/.config /sbin/.local && \
	pip3 install --no-cache-dir --upgrade pip

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD [ "/app/docker-entrypoint.sh" ]
