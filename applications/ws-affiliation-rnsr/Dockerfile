# syntax=docker/dockerfile:1.2
FROM python:slim-bullseye as build1
WORKDIR /dvc
COPY ./public/v2/affiliation/models.dvc /dvc
RUN apt update && apt -y install git
RUN pip install dvc[all]==2.48
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
RUN pip install fasttext==0.9.2
WORKDIR /app/public/v2/affiliation/models
COPY ./config.json ./package-app.json /app/
COPY ./public/swagger.json /app/public/
COPY ./public/v2/affiliation/ /app/public/v2/affiliation/
COPY --from=build1 /dvc/models /app/public/v2/affiliation/models/

WORKDIR /app

EXPOSE 31976
