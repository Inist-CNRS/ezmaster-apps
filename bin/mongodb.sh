#!/bin/sh
NAME=mongo
EXITED=$(docker ps -a --filter="name=${NAME}" --filter "status=exited" |grep -w "${NAME}")
RUNNING=$(docker ps -a --filter="name=${NAME}" --filter "status=running" |grep -w "${NAME}")
if [ -n "${EXITED}" ]; then
    echo "${NAME} start ..."
	docker start "${NAME}"
elif [ -z "${RUNNING}" ]; then
	echo "${NAME} create and start..."
	docker run --net=host --name mongo -v "${HOME}/.mongodb/data/db:/data/db" -p 27017:27017 -d mongo:4.4.4-bionic
else
	echo "${NAME} running..."
fi
