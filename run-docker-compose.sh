#!/bin/bash

echo "launch Container"
docker-compose up -d
sleep 5

echo "Exec code in container to create user"
sleep 1
docker-compose exec mongodb mongosh --username root --password evanrootpassword --authenticationDatabase admin --eval 'db.getSiblingDB("todoapp").createUser({user: "evan", pwd: "evantodoapp", roles: [{ role: "readWrite", db: "todoapp" }, { role: "dbAdmin", db: "todoapp" }]})'