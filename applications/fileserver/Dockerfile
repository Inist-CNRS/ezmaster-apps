FROM drakkan/sftpgo:v2.5.4-alpine
USER root
RUN  apk add --no-cache su-exec tini curl
ENV SFTPGO_WEBDAVD__BINDINGS__0__PORT="10080"
RUN echo '{ \
  "httpPort": 8080, \
  "configPath": "/etc/sftpgo/sftpgo.json", \
  "configType": "json", \
  "dataPath": "/srv/sftpgo", \
  "technicalApplication": true \
}' > /etc/ezmaster.json

EXPOSE 8080
EXPOSE 10080
ADD docker-entrypoint.sh /
ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD [ "/docker-entrypoint.sh" ]
