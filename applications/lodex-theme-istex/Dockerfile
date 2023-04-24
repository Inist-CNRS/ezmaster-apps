FROM inistcnrs/lodex:12.55.2
RUN npm install -g github-files-fetcher && \
	fetcher --url="https://github.com/Inist-CNRS/lodex-themes/tree/istex%401.1.0/istex" --out="/tmp" && \
	mv -f /tmp/istex/* /app/src/app/custom/
