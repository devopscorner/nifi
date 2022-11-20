#!/usr/bin/env sh

# ================================================================================================
#  INSTALL DOCKER
# ================================================================================================
export DEBIAN_FRONTEND=noninteractive
export DOCKER_PATH="/usr/bin/docker"
export DOCKER_COMPOSE_PATH="/usr/bin/docker-compose"
export DOCKER_COMPOSE_VERSION="1.27.4"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update
apt-cache policy docker-ce

apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
    docker-ce

# ================================================================================================
#  INSTALL DOCKER-COMPOSE
# ================================================================================================
curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` -o $DOCKER_COMPOSE_PATH

chmod +x /usr/bin/docker-compose

##### CUSTOMIZE ~/.profile #####
echo '' >> ~/.profile
echo '### Docker ###
export DOCKER_CLIENT_TIMEOUT=300
export COMPOSE_HTTP_TIMEOUT=300' >> ~/.profile

# reload source ~/.profile
/bin/bash -c "source ~/.profile"

##### CONFIGURE DOCKER #####
usermod -aG docker $USER

ln -snf $DOCKER_PATH /usr/bin/dock
ln -snf $DOCKER_COMPOSE_PATH /usr/bin/dock
