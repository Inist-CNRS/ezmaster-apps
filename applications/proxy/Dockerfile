FROM node:lts-alpine

WORKDIR /app

# see https://github.com/Inist-CNRS/ezmaster
RUN echo '{ \
  "httpPort": 8000, \
  "configPath": "/app/config.json", \
  "dataPath": "/app/data", \
  "technicalApplication": true \
}' > /etc/ezmaster.json


COPY package*.json /app/

RUN npm ci --only=production

# see .dockerignore
COPY * /app/

EXPOSE 8000
CMD ["npm", "start"]
