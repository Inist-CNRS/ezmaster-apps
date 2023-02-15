#!/bin/sh

cd /app || exit 1;

# installation des packges additionnels
PACKAGES_MEMORY="./packages.installed"
PACKAGES=`node -e 'process.stdout.write(Array().concat(require("./config.json").packages).filter(Boolean).join(" ").trim())'`

touch ${PACKAGES_MEMORY}
PACKAGES_CHECK=`cat ${PACKAGES_MEMORY}`
if [ -n "${PACKAGES}" ] && [ "${PACKAGES_CHECK}" != "${PACKAGES}" ]
then
	npm install --production  ${PACKAGES}
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
find /app/public ! -user daemon -exec chown daemon:daemon {} \; &
find /tmp ! -user daemon -exec chown daemon:daemon {} \; &

# environnement vars
node ./generate-dotenv.js
set -a
source /app/.env
set +a

# launch make
cd /app/public && make &

# launch public web server
su-exec daemon:daemon npm start
