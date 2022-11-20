#!/usr/bin/env sh

# ================================================================================================
#  INSTALL AWS CLI
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

curl -O https://bootstrap.pypa.io/get-pip.py

### Python 3.x ###
python3 get-pip.py --user
pip3 install awscli --upgrade --user

### Python 2.7.x ###
# python2 get-pip.py --user
# pip install awscli --upgrade --user
