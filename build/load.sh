docker-compose down
docker image rm supertuxserver
docker image rm supertuxais
docker load<supertuxais.tar
docker load<supertuxserver.tar
docker-compose up -d