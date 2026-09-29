#!/bin/bash

echo "Loading environment variables"
set -a
source /mongot-community/env.conf
set +a

if [ ! -f /mongot-community/pwfile ]; then
    if [ -v MONGOT_PASSWD ]; then
        echo $MONGOT_PASSWD >/mongot-community/pwfile
        chmod 400 /mongot-community/pwfile
        chown mongodb:mongodb /mongot-community/pwfile
    else
        echo "ERROR: MONGOT_PASSWD must be set"
        exit 1
    fi
fi

set -e

echo "Waiting MongoDB start"
echo "[init] Waiting for mongod to be ready..."
until mongosh "mongodb://localhost:27017" --eval "db.adminCommand('ping')" --quiet; do
    sleep 1
done

echo "Initialize Replica..."
mongosh --eval "
rs.initiate({
  _id: 'rs0',
  members: [
    { _id: 0, host: 'localhost:27017' }
  ]
})
" || true

PASSWORD=$(cat /mongot-community/pwfile)

# Create user using local connection (no port specification needed)
echo "Creating user..."
mongosh --eval "
const adminDb = db.getSiblingDB('admin');
try {
adminDb.createUser({
   user: 'mongotUser',
   pwd: '${PASSWORD}',
   roles: [{ role: 'searchCoordinator', db: 'admin' }]
});
print('User mongotUser created successfully');
} catch (error) {
if (error.code === 11000) {
   print('User mongotUser already exists');
} else {
   print('Error creating user: ' + error);
}
}
"
echo "MongoDB initialization completed."
