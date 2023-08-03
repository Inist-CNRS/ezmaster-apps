# syntax=docker/dockerfile:1.2
FROM inistcnrs/lodex-workers-python:4.0.11 AS release
RUN pip install vaderSentiment==3.3.2
COPY ./config.json ./package-app.json /app/
COPY ./public/swagger.json /app/public/
COPY ./public/v1/sentimens/ /app/public/v1/sentiments/

WORKDIR /app

EXPOSE 31976
