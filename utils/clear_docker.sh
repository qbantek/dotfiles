#!/bin/bash

# Delete all stopped containers
docker ps -q -f status=exited | xargs docker rm
# Delete all dangling (unused) images
docker images -q -f dangling=true | xargs docker rmi
