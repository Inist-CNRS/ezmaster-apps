#!/bin/bash

set -e

echo "Starting MongoDB initialization..."
sleep 3 


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
