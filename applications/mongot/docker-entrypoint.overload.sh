#!/bin/bash

set -e

# Génère le mot de passe uniquement si le fichier n'existe pas encore
if [ ! -f /mongot-community/pwfile ]; then
    openssl rand -base64 32 > /mongot-community/pwfile
	chmod 400 /mongot-community/pwfile
	echo -n '# Paswword : '  >> /mongot-community/config.user.yml
	cat /mongot-community/pwfile >> /mongot-community/config.user.yml
fi

# Fusionne les fichiers de configuration, entre la partie personnailisable et la partie imposée
yq eval-all 'select(fileIndex == 0) * select(fileIndex == 1)' /mongot-community/config.user.yml /mongot-community/config.system.yml > /mongot-community/config.default.yml


# start mongot daemon
exec sh -c '/mongot-community/mongot --config /mongot-community/config.default.yml'
