FROM qdrant/qdrant:v1.17

RUN mkdir -p /app && echo '{ \
  "httpPort": 6333, \
  "configPath": "/qdrant/config/production.yaml", \
  "configType": "txt", \
  "dataPath": "/app", \
  "technicalApplication": true \
}' > /etc/ezmaster.json

