FROM redis:7.0.4-alpine
EXPOSE 3000 
EXPOSE 6379
RUN echo '{ \
  "httpPort": 3000, \
  "configPath": "/usr/local/etc/redis/redis.conf", \
  "configType": "text", \
  "dataPath":   "/data", \
  "technicalApplication": true \
}' > /etc/ezmaster.json && \
    apk add --no-cache nodejs-current
COPY docker-entrypoint.overload.sh /usr/local/bin/
COPY server.js /usr/local/lib/
COPY redis.conf /usr/local/etc/redis/redis.conf
ENTRYPOINT [ "docker-entrypoint.overload.sh" ]
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
