FROM qdrant/qdrant:v1.17
RUN echo '{ \
  "httpPort": 6333, \
  "configPath": "/qdrant/config/production.yaml", \
  "configType": "txt", \
  "dataPath": "/qdrant/storage", \
  "technicalApplication": true \
}' > /etc/ezmaster.json

