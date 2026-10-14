#!/command/with-contenv bash

echo "Loading environment variables"
set -a
source /etc/environment.conf
set +a

echo "Initialize config files"

set -e

if [ ! -f /etc/mongod/keyfile ]; then
    if [ -v MONGOD_CLUSTER_PASSWORD ]; then
        mkdir -p /etc/mongod
        printf '%s' "$MONGOD_CLUSTER_PASSWORD" >/etc/mongod/keyfile
        chmod 400 /etc/mongod/keyfile
        chown mongodb:mongodb /etc/mongod/keyfile
    else
        echo "ERROR: environment variable MONGOD_SEARCH_PASSWORD must be set"
        exit 1
    fi
fi

if [ ! -f /etc/mongod/schpwd ]; then
    if [ -v MONGOD_SEARCH_PASSWORD ]; then
        mkdir -p /etc/mongod
        printf '%s' "$MONGOD_SEARCH_PASSWORD" >/etc/mongod/schpwd
        chmod 400 /etc/mongod/schpwd
        chown mongodb:mongodb /etc/mongod/schpwd
    else
        echo "ERROR: environment variable MONGOD_SEARCH_PASSWORD must be set"
        exit 1
    fi
fi

if [ ! -f /etc/mongod/admpwd ]; then
    if [ -v MONGOD_ADMIN_PASSWORD ]; then
        mkdir -p /etc/mongod
        printf '%s' "$MONGOD_ADMIN_PASSWORD" >/etc/mongod/admpwd
        chmod 400 /etc/mongod/admpwd
        chown mongodb:mongodb /etc/mongod/admpwd
    else
        echo "ERROR: environment variable MONGOD_ADMIN_PASSWORD must be set"
        exit 1
    fi
fi

if [ ! -f /etc/mongod/apppwd ]; then
    if [ -v MONGOD_APPUSER_PASSWORD ]; then
        mkdir -p /etc/mongod
        printf '%s' "$MONGOD_APPUSER_PASSWORD" >/etc/mongod/apppwd
        chmod 400 /etc/mongod/apppwd
        chown mongodb:mongodb /etc/mongod/apppwd
    else
        echo "ERROR: environment variable MONGOD_APPUSER_PASSWORD must be set"
        exit 1
    fi
fi

if [ "$RS_SECONDARY_NODE" != "true" ]; then
    mkdir -p /etc/mongod
    touch /etc/mongod/primary
    chmod 400 /etc/mongod/primary
    chown mongodb:mongodb /etc/mongod/primary
fi

if [ -v RS_SECONDARY_HOSTS ]; then
    echo "$RS_SECONDARY_HOSTS" | tr "," "\n" >/etc/mongod/hosts
fi
