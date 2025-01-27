FROM mongodb/mongodb-community-server:7.0.9-ubi9

# need jq to parse JSON
# netcat to wait for when mongo is ready to listen
# tmpreaper to cleanup old dump
# python for a basic http server used for ezmaster
# vim for debug stuff
USER root
RUN yum -y install nc jq vim

COPY config.json /
COPY docker-entrypoint.overload.sh /usr/local/bin/

# mongo data folder dedicated to ezmaster
# because it's not yet (8 nov 2017) possible to UNVOLUME /data/db and /data/configdb
RUN mkdir -p /ezdata/db && chown -R mongod:mongod /ezdata/db

# backup stuff
RUN mkdir -p /ezdata/dump && chown -R mongod:mongod /ezdata/dump
COPY dump.periodically.sh /usr/local/bin/

# basic http server stuff
RUN mkdir /www
COPY index.* /www/

# ezmasterization of ezmaster-mongo
# see https://github.com/Inist-CNRS/ezmaster
# notice: httpPort is useless here but as ezmaster require it (v3.8.1) we just add a wrong port number
RUN echo '{ \
  "httpPort": 3000, \
  "configPath": "/config.json", \
  "configType": "json", \
  "dataPath": "/ezdata", \
  "technicalApplication": true \
}' > /etc/ezmaster.json

USER mongod
ENTRYPOINT [ "docker-entrypoint.overload.sh" ]
CMD [ "mongod", "--bind_ip_all", "--dbpath", "/ezdata/db", "--nounixsocket" ]
