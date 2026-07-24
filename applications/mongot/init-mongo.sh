#!/bin/bash

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
"
PASSWORD=`cat /mongot-community/pwfile`

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
