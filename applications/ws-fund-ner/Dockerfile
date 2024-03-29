# syntax=docker/dockerfile:1.2
FROM python:3.8-slim-bullseye as build1
WORKDIR /app/public
RUN apt update && apt -y install git curl unzip
RUN pip install dvc[webdav]==3.28.0
RUN --mount=type=secret,id=webdav_login \
    --mount=type=secret,id=webdav_password \
    --mount=type=secret,id=webdav_url \
    git init && \
    dvc init && \
    dvc remote add -d webdav-remote "$(cat /run/secrets/webdav_url)" && \
    dvc remote modify --local webdav-remote user "$(cat /run/secrets/webdav_login)" && \
    dvc remote modify --local webdav-remote password "$(cat /run/secrets/webdav_password)"
RUN curl https://gitbucket.inist.fr/tdm/web-services/archive/fund-ner/fund-ner@1.0.1.zip --output source.zip && \
    unzip source.zip && \
    dvc pull

FROM inistcnrs/lodex-workers-pytorch:1.0.3 AS release
RUN pip install wheel &&\  
    pip install flair==0.10 &&\
    pip install certifi==2019.11.28
WORKDIR /app/public/
RUN rm /app/public/expand.ini expand.py && \
    mkdir /app/.cache/ && \
    chmod a+w /app/.cache/
COPY ./config.json ./package-app.json /app/
COPY --from=build1 /app/public/fund-ner/ /app/public/

WORKDIR /app

EXPOSE 31976