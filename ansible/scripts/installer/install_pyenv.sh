#!/usr/bin/env sh

# ================================================================================================
#  INSTALL PyEnv (Python Version Management)
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

### Cleanup old python ###
apt-get remove python
rm -rf /usr/bin/pip

export PYTHON2_VER="2.7.15"
export PYTHON3_VER="3.8.1"
export PATH_PYENV="$HOME/.pyenv"
git clone git@github.com:pyenv/pyenv.git "$PATH_PYENV"

### Path pyenv (Python Version Manager) ###
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile

# source ~/.profile
/bin/bash -c "source ~/.profile"

cd "$PATH_PYENV"
### Install python 2 ###
pyenv install $PYTHON2_VER
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
  && python get-pip.py \
  && pip install coverage junit-xml

pip install --upgrade pip

### Install python 3 ###
pyenv install $PYTHON3_VER
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
  && python get-pip.py \
  && pip install coverage junit-xml

pip3 install --upgrade pip

### Setup python environment global ###
pyenv global $PYTHON2_VER
pyenv rehash
