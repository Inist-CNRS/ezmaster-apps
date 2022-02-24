FROM inistcnrs/lodex-workers:9.0.5
RUN apk add --no-cache g++ snappy-dev autoconf automake libtool
WORKDIR /src/libpostal
RUN git clone https://github.com/openvenues/libpostal /src/libpostal && \
	./bootstrap.sh && \
	mkdir /data && \
    ./configure --prefix=/usr --datadir=/usr/share/libpostal
RUN	make && \
	make check && \
	make install && \
	ldconfig /  && \
	rm -rf /src
WORKDIR /app/local
RUN npm install -g node-gyp && \
    npm install && \
    npm install @cymen/node-postal@2.0.5 && \
    npm rebuild
WORKDIR /app
