FROM nginx:1.13.3

# basic command used for debugging ezmaster stuff
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get -y install vim curl gnupg2 git netcat

# nodejs installation used for startup scripts
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y build-essential nodejs

# web-term installation
# https://github.com/IonicaBizau/web-term/
RUN npm install --unsafe-perm -g web-term@5.1.2

# install starting stuff (npm start)
RUN mkdir -p /app
WORKDIR /app
COPY ./package.json /app/package.json
RUN npm install

# nginx config
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./entrypoint-scripts-runner /bin/entrypoint-scripts-runner

# ezmasterization stuff
# see https://github.com/Inist-CNRS/ezmaster
RUN echo '{ \
  "httpPort": 80, \
  "configPath": "/etc/nginx/nginx.conf", \
  "configType": "text", \
  "dataPath":   "/app" \
}' > /etc/ezmaster.json

EXPOSE 80
ENTRYPOINT [ "npm", "start" ]
