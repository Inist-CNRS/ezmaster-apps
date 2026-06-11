FROM mongodb/mongodb-community-search:1.67.1

RUN yum install -y wget && \
    wget -qO /usr/local/bin/yq \
      https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 && \
    chmod +x /usr/local/bin/yq

COPY docker-entrypoint.overload.sh /usr/local/bin/
COPY mongot.yaml /mongot-community/config.system.yml
COPY config.yaml /mongot-community/config.user.yml

EXPOSE 9946
# ezmasterization of ezmaster-mongo
# see https://github.com/Inist-CNRS/ezmaster
# notice: httpPort is useless here but as ezmaster require it (v3.8.1) we just add a wrong port number
RUN echo '{ \
  "httpPort": 9946, \
  "configPath": "/etc/mongot.conf", \
  "configType": "txt", \
  "dataPath": "/mongot-community/config.user.yml", \
  "technicalApplication": true \
}' > /etc/ezmaster.json
ENTRYPOINT [ "docker-entrypoint.overload.sh" ]
