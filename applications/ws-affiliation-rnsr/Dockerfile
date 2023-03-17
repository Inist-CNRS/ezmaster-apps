# syntax=docker/dockerfile:1.2
FROM inistcnrs/lodex-workers-python:4.0.11 as build1
WORKDIR /dvc
COPY ./public/v2/affiliation/models.dvc /dvc
RUN --mount=type=secret,id=webdav_login \
    --mount=type=secret,id=webdav_password \
    --mount=type=secret,id=webdav_url \
    pip install dvc[webdav]==2.48 && \
    git init && \
    dvc init && \
    dvc remote add -d webdav-remote "$(cat /run/secrets/webdav_url)" && \
    dvc remote modify --local webdav-remote user "$(cat /run/source/webdav_login)" && \
    dvc remote modify --local webdav-remote password "$(cat /run/secrets/webdav_password)" && \
    dvc pull

FROM inistcnrs/lodex-workers-python:4.0.11 AS release
RUN pip install fasttext==0.9.2
WORKDIR /app/public/v2/affiliation
COPY ./public/v2/affiliation/ /app/public/v2/affiliation/
COPY --from=build1 /dvc/models /app/public/v2/affiliation/
