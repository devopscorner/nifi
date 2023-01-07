#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build Container
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="nifi-registry"

export IMAGE="$CI_PROJECT_PATH/$CI_PROJECT_NAME"

TAG="latest"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile -t $IMAGE:$TAG .
echo ""

TAG="1.16.3"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-1.16 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $IMAGE:1.16
echo ""

TAG="1.17.0"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-1.17 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $IMAGE:1.17
echo ""

TAG="1.18.0"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-1.18 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $IMAGE:1.18
echo ""

TAG="1.18-ubuntu"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-1.18 -t $IMAGE:$TAG .
echo ""

echo "Cleanup Unknown Tags"
echo "docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi"
docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi
echo ""

echo "-- ALL DONE --"
