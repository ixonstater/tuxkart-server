#!/bin/bash
cd /home/ixonstater/code/super-tux/ais
docker-compose -f build-image.yml build
cd ../server
docker-compose -f build-image.yml build
cd ../build
docker save supertuxais>supertuxais.tar
docker save supertuxserver>supertuxserver.tar
rsync -p --progress ./supertuxserver.tar ixonstater@codefordays.io:~/supertux
rsync -p --progress ./supertuxais.tar ixonstater@codefordays.io:~/supertux
rsync -p --progress ../server_config.xml ixonstater@codefordays.io:~/supertux
rsync -p --progress ../docker-compose.yml ixonstater@codefordays.io:~/supertux
rsync -p --progress ./load.sh ixonstater@codefordays.io:~/supertux