FROM stain/jena-fuseki

RUN apt-get update && apt-get install -y procps

# ----------------------------------------------- #
# ezMaster configuration                          #
# ----------------------------------------------- #
EXPOSE 3030
RUN echo '{ \
  "httpPort": 3030, \
  "dataPath": "/staging", \
  "configPath": "/fuseki/config.ttl", \
  "technicalApplication": true, \
  "configType": "text" \
}' > /etc/ezmaster.json
# ----------------------------------------------- #

COPY docker-entrypoint.overload.sh /
RUN chmod 755 /docker-entrypoint.overload.sh

COPY config.ttl /fuseki/config.ttl

ENTRYPOINT [ "/docker-entrypoint.overload.sh" ]
CMD ["/jena-fuseki/fuseki-server"]
