FROM inistcnrs/lodex:12.22.4
RUN npm install -g github-files-fetcher && \
	fetcher --url="https://github.com/Inist-CNRS/lodex-themes/tree/v1.0.0/istex" --out="/tmp" && \
	mv -f /tmp/istex/* /app/src/app/custom/
