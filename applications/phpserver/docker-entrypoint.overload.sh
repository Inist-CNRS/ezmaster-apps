#!/bin/sh
set -e

# adjust mail server parmeters from php.ini values
SMTP_HOST=$(php -r "echo ini_get('SMTP');")
SMTP_PORT=$(php -r "echo ini_get('smtp_port');")
sed -i "s/hostname=.*/hostname=$SMTP_HOST:$SMTP_PORT/g" /etc/esmtprc

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- apache2-foreground "$@"
fi

/usr/local/bin/composer-install.sh &

# Fix permissions : avoid different user:group in the exposed directory
# to allow webdav server to modify all files
find /var/www/html ! -user www-data -exec chown www-data:daemon {} \; &
# to allow daemon to use temp directory
chmod 1777 /tmp

exec "$@"
