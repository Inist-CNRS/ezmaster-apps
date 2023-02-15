FROM inistcnrs/lodex:12.42.0
RUN npm install -g github-files-fetcher && \
	fetcher --url="https://github.com/Inist-CNRS/lodex-themes/tree/v2.0.0/istex" --out="/tmp" && \
	mv -f /tmp/istex/* /app/src/app/custom/
