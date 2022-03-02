FROM node:lts-alpine

WORKDIR /app

# see https://github.com/Inist-CNRS/ezmaster
RUN echo '{ \
  "httpPort": 3000, \
  "configPath": "/app/config.json", \
  "dataPath": "/app/data", \
  "technicalApplication": true \
}' > /etc/ezmaster.json


RUN npm init -y && \
	npm install recluster@1.0.0

# see .dockerignore
COPY config.json index.js server.js /app/

EXPOSE 3000
ENTRYPOINT ["node"]
CMD ["index.js"]
