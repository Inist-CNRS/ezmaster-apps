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

# generate .env
node ./generate-dotenv.js

# Restauration du owner
find /app/public ! -user daemon -exec chown daemon:daemon {} \; &
find /tmp ! -user daemon -exec chown daemon:daemon {} \; &

su-exec daemon:daemon npm run prod
