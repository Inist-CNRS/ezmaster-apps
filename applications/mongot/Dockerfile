FROM mongodb/mongodb-community-search:1.70.5 AS mongot-base

FROM mongodb/mongodb-community-server:9.0.2-ubuntu2204

USER root

ARG S6_OVERLAY_VERSION=3.1.6.2

# Installer s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp/
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp/
RUN apt-get update && apt-get install -y xz-utils && \
    tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz && \
    tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz && \
    rm /tmp/*.tar.xz && \
    rm -rf /var/lib/apt/lists/*

# Copier mongot
COPY --from=mongot-base /mongot-community /mongot-community

# Créer les répertoires
RUN mkdir -p \
    /data/db \
    /data/mongot \
    /var/log/mongodb \
    && chown -R mongodb:mongodb \
    /data \
    /mongot-community \
    /var/log/mongodb

# Copier les configs
COPY mongod.conf /etc/mongod.conf
COPY --chmod=0755 init-mongo.sh /bin/
COPY mongot.conf /mongot-community/config.default.yml
COPY --chmod=0755 environment.sh /bin/
COPY environment.conf /etc/environment.conf


# Copier la config s6
COPY s6-config/s6-rc.d /etc/s6-overlay/s6-rc.d

# Rendre les scripts exécutables
RUN chmod +x \
    /etc/s6-overlay/s6-rc.d/mongod/run \
    /etc/s6-overlay/s6-rc.d/mongod/finish \
    /etc/s6-overlay/s6-rc.d/mongot/run \
    /etc/s6-overlay/s6-rc.d/mongot/finish \
    /etc/s6-overlay/s6-rc.d/init-mongo/up

EXPOSE 27017


# ezmasterization of ezmaster-mongo
# see https://github.com/Inist-CNRS/ezmaster
# notice: httpPort is useless here but as ezmaster require it (v3.8.1) we just add a wrong port number
RUN echo '{ \
    "httpPort": 27017, \
    "configPath": "/etc/environment.conf", \
    "configType": "txt", \
    "dataPath": "/data", \
    "technicalApplication": true \
    }' > /etc/ezmaster.json

ENTRYPOINT ["/init"]
