FROM inistcnrs/lodex:12.21.0
RUN npm install -g github-files-fetcher && \
	fetcher --url="https://github.com/Inist-CNRS/lodex-themes/tree/v1.0.0/daf" --out="/tmp" && \
	mv -f /tmp/daf/* /app/src/app/custom/ && \
	mv /app/src/app/custom/config.json /app

