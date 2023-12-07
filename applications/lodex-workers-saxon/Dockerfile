FROM node:14-alpine AS build

#ARG saxon_ver=9.9.1-7
#ARG saxon_ver=11.4
ARG saxon_ver=10.9

ADD files /files

RUN chmod a+x /files/*/bin/* \
 && chmod a+r -R /files \
 && find /files -type f | sort

ADD \
  https://repo1.maven.org/maven2/net/sf/saxon/Saxon-HE/${saxon_ver}/Saxon-HE-${saxon_ver}.jar \
  /files/he/usr/share/java/saxon/saxon.jar

FROM inistcnrs/lodex-workers:9.3.1
ENV SAXON_HOME=/usr/share/java/saxon
COPY --from=build /files/he /
RUN cd / && \
	curl -o fop.zip "http://archive.apache.org/dist/xmlgraphics/fop/binaries/fop-2.6-bin.zip" && \
	unzip fop.zip && \
    rm fop.zip && \
    chmod +x /fop-2.6/fop/fop && \
	mv /fop-2.6/fop /fop && \
	echo '#!/bin/sh'  > /bin/xslt && \
	echo 'exec /usr/bin/java -jar /usr/share/java/saxon/saxon.jar "$@"'  >> /bin/xslt && \
	chmod 755 /bin/xslt && \
	chmod 644 /usr/share/java/saxon/saxon.jar
ENV PATH="/fop:$PATH"
WORKDIR /app
# To be compilant with
# - Debian/Ubuntu container (and so with ezmaster-webdav)
# - ezmaster see https://github.com/Inist-CNRS/ezmaster
COPY ./config.json /app/
COPY ./public/parse.ini ./public/parse.xsl /app/public/
RUN apk add --update-cache --no-cache su-exec bash git openssh openjdk8-jre jq poppler-utils && \
	echo '{ \
      "httpPort": 31976, \
      "configPath": "/app/config.json", \
      "dataPath": "/app/public" \
    }' > /etc/ezmaster.json && \
    sed -i -e "s/daemon:x:2:2/daemon:x:1:1/" /etc/passwd && \
    sed -i -e "s/daemon:x:2:/daemon:x:1:/" /etc/group && \
    sed -i -e "s/bin:x:1:1/bin:x:2:2/" /etc/passwd && \
    sed -i -e "s/bin:x:1:/bin:x:2:/" /etc/group
ENTRYPOINT [ "/app/docker-entrypoint.sh" ]
CMD [ "npm", "start" ]
