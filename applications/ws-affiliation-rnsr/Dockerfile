# syntax=docker/dockerfile:1.2
FROM inistcnrs/lodex-workers-python:4.0.11 as build1
RUN --mount=type=secret,id=webdav_login \
    --mount=type=secret,id=webdav_password \
    --mount=type=secret,id=webdav_url cat/secrets/url \
    pip install dvc[webdav]==2.48 && \
    git init && \
    dvc init && \
    dvc remote add -d webdav-remote "${WEBDAV_URL}" && \
    dvc remote modify --local webdav-remote user "${WEBDAV_LOGIN}" && \
    dvc remote modify --local webdav-remote password "${WEBDAV_PASSWORD}" && \
    dvc pull
    
    #Verifier ici


FROM inistcnrs/lodex-workers-python:4.0.11
RUN pip install fasttext==0.9.2
WORKDIR /app/public
COPY /models /app/public/v2/affiliation
WORKDIR /app

COPY logins.env .
RUN source logins.env && \
    dvc remote add -d webdav-remote "${WEBDAV_URL}" && \
    dvc remote modify --local webdav-remote user "${WEBDAV_LOGIN}" && \
    dvc remote modify --local webdav-remote password "${WEBDAV_PASSWORD}" && \
    dvc pull