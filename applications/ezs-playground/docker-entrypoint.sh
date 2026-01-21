#!/bin/sh

cd /app || exit 1;

# generate .env
node ./generate-dotenv.js

# Restauration du owner
find /app/public ! -user daemon -exec chown daemon:daemon {} \; &
find /tmp ! -user daemon -exec chown daemon:daemon {} \; &

su-exec daemon:daemon npm run prod
