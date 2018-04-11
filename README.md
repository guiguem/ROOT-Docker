# ROOT-DOCKER

This repo contains the Dockerfile (and associated scripts) to generate a Docker image containing ROOT.
The image is built locally and pushed to Docker-Hub.

Typical commands to run from this folder:

docker build -t root-docker:python3 .      
docker tag root-docker:python3 guiguem/root-docker:python3      
docker push guiguem/root-docker:python3      
