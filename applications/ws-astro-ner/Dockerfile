# syntax=docker/dockerfile:1.2
FROM python:3.9-slim-bullseye as build1
WORKDIR /app/public
RUN apt update && apt -y install git curl
RUN curl https://gitbucket.inist.fr/tdm/web-services/archive/astro-ner/astro-ner@1.0.1.zip --output source.zip && \
    unzip source.zip
RUN pip install dvc[webdav]==3.24.0
RUN --mount=type=secret,id=webdav_login \
    --mount=type=secret,id=webdav_password \
    --mount=type=secret,id=webdav_url \
    git init && \
    dvc init && \
    dvc remote add -d webdav-remote "$(cat /run/secrets/webdav_url)" && \
    dvc remote modify --local webdav-remote user "$(cat /run/secrets/webdav_login)" && \
    dvc remote modify --local webdav-remote password "$(cat /run/secrets/webdav_password)" && \
    dvc pull

FROM inistcnrs/lodex-workers-python:4.0.11 AS release
RUN pip install flair==0.10
WORKDIR /app/public/v3/affiliation/models
COPY ./config.json ./package-app.json /app/
COPY ./public/swagger.json /app/public/
COPY ./public/v2/affiliation/ /app/public/v2/affiliation/
COPY ./public/v3/affiliation/ /app/public/v3/affiliation/
COPY --from=build1 /dvc/models /app/public/v3/affiliation/models/

WORKDIR /app

EXPOSE 31976
