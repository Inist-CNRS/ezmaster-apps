FROM mongodb/mongodb-community-search:latest AS mongot-base

FROM mongodb/mongodb-community-server:latest

USER root

RUN apt-get update && apt-get install -y \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Copier mongot depuis son image
COPY --from=mongot-base /mongot-community /mongot-community

# Créer les répertoires
RUN mkdir -p \
    /data/db \
    /data/mongot \
    /var/log/mongodb \
    /var/log/mongot \
    /var/log/supervisor \
    /var/run/supervisor \
    /var/run/mongodb \
    && chown -R mongodb:mongodb \
        /data \
        /var/log/mongodb \
        /var/log/mongot \
        /var/run/mongodb \
        /mongot-community

COPY docker-entrypoint.overload.sh /usr/local/bin/
COPY ./init-mongo.sh /usr/local/bin/
COPY ./pwfile /mongot-community/pwfile
COPY mongod.conf /etc/mongod.conf
COPY mongot.conf /mongot-community/config.default.yml
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod 400 /mongot-community/pwfile && \
    chown -R mongodb:mongodb /mongot-community/pwfile

EXPOSE 27017 27028 9946 8080

ENTRYPOINT [ "docker-entrypoint.overload.sh" ]

