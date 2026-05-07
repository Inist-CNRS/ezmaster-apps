FROM node:lts-alpine

WORKDIR /app

# see https://github.com/Inist-CNRS/ezmaster
RUN echo '{ \
  "httpPort": 3003, \
  "configPath": "/app/config.json", \
  "dataPath": "/app/data", \
  "technicalApplication": true \
}' > /etc/ezmaster.json


RUN npm init -y && \
	npm install express@4.18.0 axios@1.6.0 cookie-parser@1.4.6

# see .dockerignore
COPY config.json index.js  /app/

EXPOSE 3003
ENTRYPOINT ["node"]
CMD ["index.js"]
