FROM inistcnrs/lodex-workers-python:4.0.11
RUN pip install dvc[webdav]==2.48 fasttext==0.9.2
WORKDIR /app/public
COPY /models /app/public/
RUN dvc pull
WORKDIR /app
