#!/bin/sh
# chmod a+x runDocker.sh

docker stop reverseproxy
docker rm reverseproxy
docker rmi reverseproxy
