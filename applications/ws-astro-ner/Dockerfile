# syntax=docker/dockerfile:1.2
FROM python:3.9-slim-bullseye as build1
WORKDIR /app/public
RUN apt update && apt -y install git curl unzip
RUN pip install dvc[webdav]==3.24.0
RUN --mount=type=secret,id=webdav_login \
    --mount=type=secret,id=webdav_password \
    --mount=type=secret,id=webdav_url \
    git init && \
    dvc init && \
    dvc remote add -d webdav-remote "$(cat /run/secrets/webdav_url)" && \
    dvc remote modify --local webdav-remote user "$(cat /run/secrets/webdav_login)" && \
    dvc remote modify --local webdav-remote password "$(cat /run/secrets/webdav_password)"
RUN curl https://gitbucket.inist.fr/tdm/web-services/archive/astro-ner/astro-ner@1.0.4.zip --output source.zip && \
    unzip source.zip && \
    dvc pull

FROM inistcnrs/lodex-workers-pytorch:1.0.3 AS release
RUN pip install flair==0.10 certifi==2023.7.22 Unidecode==1.3.7
WORKDIR /app/public/
RUN rm /app/public/expand.ini expand.py
COPY ./config.json ./package-app.json /app/
COPY --from=build1 /app/public/astro-ner/ /app/public/

WORKDIR /app

EXPOSE 31976
