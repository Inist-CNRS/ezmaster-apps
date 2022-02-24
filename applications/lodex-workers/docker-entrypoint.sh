#!/bin/sh

# installation des packges additionnels
PACKAGES_MEMORY="./packages.installed"
PACKAGES=`node -e 'process.stdout.write(Array().concat(require("./config.json").packages).filter(Boolean).join(" ").trim())'`

touch ${PACKAGES_MEMORY}
PACKAGES_CHECK=`cat ${PACKAGES_MEMORY}`
if [ -n "${PACKAGES}" ] && [ "${PACKAGES_CHECK}" != "${PACKAGES}" ]
then
	npm install --production  ${PACKAGES} &
	echo "${PACKAGES}" > ${PACKAGES_MEMORY}
fi

# configuration
ZIP_URL=`node -e 'process.stdout.write(Array().concat(require("./config.json").files.zip).filter(Boolean).pop()||"")'`

# récupération des fichiers
if [ -n "${ZIP_URL}" ]
then
	/app/zipsyncdir "$ZIP_URL"
fi

# Restauration du owner
find /app/public ! -user daemon -exec chown daemon:daemon {} \;
chown daemon:daemon /tmp

# lancement des daemons
npm run watcher &
exec su-exec daemon:daemon npm start
