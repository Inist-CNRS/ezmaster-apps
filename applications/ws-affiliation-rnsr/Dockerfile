FROM inistcnrs/lodex-workers-python:4.0.11
RUN pip install dvc[all]==2.48 fasttext==0.9.2
WORKDIR /app/public
COPY /models /app/public/
RUN npm install -g node-gyp && \
    npm install && \
    npm install @cymen/node-postal@2.0.5 && \
    npm rebuild
WORKDIR /app
