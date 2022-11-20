#!/usr/bin/env sh

# ================================================================================================
#  INSTALL KUBECTX
# ================================================================================================
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
  git \
  bash \
  curl \
  wget \
  zip \
  unzip \
  software-properties-common \
  openssh-server \
  openssh-client

export KUBECTX_PATH="$GOPATH/src/github.com/kubectx"

git clone https://github.com/ahmetb/kubectx $KUBECTX_PATH

ln -snf $KUBECTX_PATH/kubectx /usr/local/bin/kubectx
ln -snf $KUBECTX_PATH/kubectx /usr/local/bin/kx

ln -snf $KUBECTX_PATH/kubens /usr/local/bin/kubens
ln -snf $KUBECTX_PATH/kubens /usr/local/bin/ks
