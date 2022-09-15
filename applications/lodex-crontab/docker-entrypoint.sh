#!/bin/sh

cd /app || exit 1;

# configuration
ZIP_URL=`node -e 'process.stdout.write(Array().concat(require("./config.json").files.zip).filter(Boolean).pop()||"")'`

# récupération des fichiers
if [ -n "${ZIP_URL}" ]
then
	/app/zipsyncdir "$ZIP_URL"
fi

# Restauration du owner
find /app/public ! -user daemon -exec chown daemon:daemon {} \; &
find /tmp ! -user daemon -exec chown daemon:daemon {} \; &

su-exec daemon:daemon npm start
