#!/bin/bash
#Change dir to app build dir
cd /home/ixonstater/code/super-tux/ais

#Build images
docker-compose -f build-image.yml build
cd ../server
docker-compose -f build-image.yml build
cd ../build

#Save images to docker hub
docker push ixonstater/stkai:latest
docker push ixonstater/stkserver:latest

#Move docker-compose and configs to server
rsync -p --progress ../server_config.xml ixonstater@codefordays.io:~/supertux
rsync -p --progress ../docker-compose.yml ixonstater@codefordays.io:~/supertux