FROM prom/pushgateway:v1.7.0

USER root
RUN echo '{ \
  "httpPort": 9091, \
  "configPath": "/pushgateway/web-config.yml", \
  "configType": "txt", \
  "dataPath": "/var/www", \
  "technicalApplication": true \
}' > /etc/ezmaster.json

USER nobody
ADD web-config.yml /pushgateway/web-config.yml
ENTRYPOINT [ "/bin/pushgateway" ]
CMD [ "--web.config.file=/pushgateway/web-config.yml" ]
