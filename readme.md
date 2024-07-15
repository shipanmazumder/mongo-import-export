# Instruction
```
chmod +x import_mongodb.sh
./import_mongodb.sh
```
# Mongo Auth With Docker Node JS

``` 
docker exec -it <mongo_container_id> mongosh

use admin
db.createUser({
  user: "",
  pwd: "",
  roles: [ { role: "root", db: "admin" } ]
})
```