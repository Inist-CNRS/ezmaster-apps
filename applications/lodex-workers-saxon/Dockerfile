FROM klakegg/saxon:base AS saxon
FROM inistcnrs/lodex-workers:9.0.5
ENV SAXON_HOME=/usr/share/java/saxon
COPY --from=saxon /he /
RUN cd / && \
	curl -o fop.zip "http://archive.apache.org/dist/xmlgraphics/fop/binaries/fop-2.6-bin.zip" && \
	unzip fop.zip && \
    rm fop.zip && \
    chmod +x /fop-2.6/fop/fop && \
	mv /fop-2.6/fop /fop
ENV PATH="/fop:$PATH"
WORKDIR /app
# To be compilant with
# - Debian/Ubuntu container (and so with ezmaster-webdav)
# - ezmaster see https://github.com/Inist-CNRS/ezmaster
COPY ./config.json ./package.json /app/
COPY ./public/parse.ini ./public/parse.xsl /app/public/
RUN apk add --update-cache --no-cache su-exec bash git openssh openjdk8-jre && \
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
