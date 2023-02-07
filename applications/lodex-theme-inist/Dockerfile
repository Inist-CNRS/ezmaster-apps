FROM inistcnrs/lodex:12.40.0
RUN npm install -g github-files-fetcher && \
	fetcher --url="https://github.com/Inist-CNRS/lodex-themes/tree/inist@1.0.5/inist" --out="/tmp" && \
	mv -f /tmp/inist/* /app/src/app/custom/
