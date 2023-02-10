FROM inistcnrs/lodex-workers:9.2.3 as build
LABEL maintainer="stephane.schneider@inist.fr"

# take a alpine and load it with previous images
FROM node:14-alpine3.15 as release
COPY --from=build /app /app

ENV \
  TT_VERSION=3.2.4 \
  TERMSUITE_VERSION=3.0.10 \
  TT_URL=http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data

# Initial system setup
RUN apk update && \
	apk add git curl build-base autoconf automake libtool

# install Treetagger
RUN mkdir -p /opt/treetagger/
WORKDIR /opt/treetagger/
RUN wget ${TT_URL}/tree-tagger-linux-${TT_VERSION}.tar.gz \
    && wget ${TT_URL}/tagger-scripts.tar.gz \
    && wget ${TT_URL}/english.par.gz \
    && wget ${TT_URL}/french.par.gz \
    && wget ${TT_URL}/german.par.gz \
    && wget ${TT_URL}/russian.par.gz \
    && wget ${TT_URL}/italian.par.gz \
    && wget ${TT_URL}/spanish.par.gz \
    && wget ${TT_URL}/install-tagger.sh \
    && sh /opt/treetagger/install-tagger.sh \
    && mv lib models  \
    && rm -rf *.gz *.tgz cmd/ doc/
WORKDIR /opt/treetagger/models/
RUN  chmod a+x /opt/treetagger/models/

# Install termsuite
WORKDIR /opt/
RUN  curl -O -L https://search.maven.org/remotecontent?filepath=fr/univ-nantes/termsuite/termsuite-core/${TERMSUITE_VERSION}/termsuite-core-${TERMSUITE_VERSION}.jar

# install java 1.8
RUN { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo; \
        echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home \
    && chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

RUN set -x \
    && apk add --no-cache \
        openjdk8 \
    && [ "$JAVA_HOME" = "$(docker-java-home)" ]

WORKDIR /app

# see .dockerignore to know all copied files
COPY ./config.json  /app/
COPY ./public /app/public/

RUN ls -lR /app/public/

RUN apk add --update-cache --no-cache \
	su-exec \
	bash \
	openssh \
	cmake \
	#python3 \
	#python3-dev \
	py3-pip \
	libgfortran \
	lapack-dev \
	openssl-dev \
	libffi-dev \
	ghostscript-dev \
	openblas-dev \
	ca-certificates \
	rust \
	tini \
	cargo \
	#cython \
	&& \
	#mv package-app.json package.json && \
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
	mkdir -p /sbin/.npm /sbin/.config /sbin/.local   && \
	chown -R daemon:daemon /app /tmp /sbin/.npm /sbin/.config /sbin/.local && \
	pip3 install --no-cache-dir --upgrade pip

ENTRYPOINT ["/sbin/tini", "-g", "--"]

CMD [ "/app/docker-entrypoint.sh" ]