#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build Container
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="openfortivpn"

export IMAGE="$CI_PROJECT_PATH/$CI_PROJECT_NAME"

TAG="latest"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile -t $IMAGE:$TAG .
echo ""

TAG="20.04"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-20.04 -t $IMAGE:$TAG .
echo ""

TAG="20.04-latest"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-20.04 -t $IMAGE:$TAG .
echo ""

TAG="20.04-1.19.0"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-20.04 -t $IMAGE:$TAG .
echo ""

TAG="22.04"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-22.04 -t $IMAGE:$TAG .
echo ""

TAG="22.04-latest"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-22.04 -t $IMAGE:$TAG .
echo ""

TAG="22.04-1.19.0"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-22.04 -t $IMAGE:$TAG .
echo ""

echo "-- ALL DONE --"
