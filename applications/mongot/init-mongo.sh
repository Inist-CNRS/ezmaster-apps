#!/bin/bash
set -e

HOSTS_FILE="/etc/mongod/hosts"

HOSTS=()
if [ -f "$HOSTS_FILE" ]; then
    while IFS= read -r line || [ -n "$line" ]; do
        line="${line%%#*}"                                # ignore les commentaires
        line="$(printf '%s' "$line" | tr -d '[:space:]')" # espaces, tabulations, \r
        [ -n "$line" ] && HOSTS+=("$line")
    done <"$HOSTS_FILE"
fi
[ ${#HOSTS[@]} -eq 0 ] && HOSTS=("localhost:27017")

FIRST_HOST="${HOSTS[0]}"

echo "[init] Waiting for mongod to be ready..."
until mongosh "mongodb://localhost:27017" --eval "db.adminCommand('ping')" --quiet; do
    sleep 1
done

# Nœuds secondaires : ajoutés depuis le nœud de bootstrap
if [ ! -f /etc/mongod/primary ]; then
    echo "[init] Secondary node, skipping initialization."
    exit 0
fi

echo "[init] Initialize Replica with ${FIRST_HOST}..."
mongosh --quiet --eval "
if (!db.hello().setName) {
  rs.initiate({ _id: 'rs0', members: [{ _id: 0, host: '${FIRST_HOST}' }] })
} else {
  print('replica set already initialized')
}"

echo "[init] Waiting for primary..."
until mongosh --quiet --eval "db.hello().isWritablePrimary" | grep -q true; do
    sleep 1
done

ADMPASSWD=$(cat /etc/mongod/admpwd)
SRHPASSWD=$(cat /etc/mongod/schpwd)
APPPASSWD=$(cat /etc/mongod/apppwd)

# Premier utilisateur via la localhost exception (échoue sans effet si déjà créé)
mongosh --quiet admin --eval "
db.createUser({ user: 'admin', pwd: '${ADMPASSWD}', roles: ['root'] })
" || true

AUTH=(-u admin -p "${ADMPASSWD}" --authenticationDatabase admin)

mongosh --quiet "${AUTH[@]}" admin --eval "
if (!db.getUser('mongotUser')) {
  db.createUser({
    user: 'mongotUser',
    pwd: '${SRHPASSWD}',
    roles: [{ role: 'searchCoordinator', db: 'admin' }]
  });
  print('mongotUser created');
} else {
  print('mongotUser already exists');
}"

mongosh --quiet "${AUTH[@]}" admin --eval "
if (!db.getUser('appUser')) {
  db.createUser({
    user: 'appUser',
    pwd: '${APPPASSWD}',
    roles: [
      { role: 'readWriteAnyDatabase', db: 'admin' },
      { role: 'dbAdminAnyDatabase',   db: 'admin' }
    ]
  });
  print('appUser created');
} else {
  print('appUser already exists');
}"

# Ajout des autres membres (réessaie tant qu'ils ne sont pas joignables)

for HOST in "${HOSTS[@]:1}"; do
    echo "[init] Adding member ${HOST}..."
    until mongosh --quiet "${AUTH[@]}" --eval "
    if (rs.conf().members.some(m => m.host === '${HOST}')) {
      print('${HOST} already a member');
    } else {
      rs.add('${HOST}');
      print('${HOST} added');
    }"; do
        echo "[init] ${HOST} not ready, retrying..."
        sleep 3
    done
done

echo "[init] MongoDB initialization completed."
