#!/usr/bin/env sh

# ================================================================================================
#  INSTALL NVM (Node Version Manager)
# ================================================================================================
export DEBIAN_FRONTEND=noninteractive

export NVM_VERSION="0.34.0"
export NODE_VERSION="12.16.1"

if ! [ "${ND_VERSION}" = "" ]
then
  NODE_VERSION=${ND_VERSION}
fi

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

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash

##### CUSTOMIZE ~/.profile #####
echo '' >> ~/.profile
echo '### Path NVM (NodeJS Version Manager) ###
export NVM_ROOT="$HOME/.nvm"
if [ -d "$NVM_ROOT" ]
then
  [ -s "$NVM_ROOT/nvm.sh" ] && . "$NVM_ROOT/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi' >> ~/.profile

# reload source ~/.profile
/bin/bash -c "source ~/.profile"

nvm install ${NODE_VERSION}
nvm alias default ${NODE_VERSION}

export BIN_NODE="$USER/.nvm/versions/node/v${NODE_VERSION}/bin/node"
export WHICH_BIN_NODE=`which node`
export NODE_PATH="/usr/bin/node"

export BIN_NPM="$USER/.nvm/versions/node/v${NODE_VERSION}/bin/npm"
export WHICH_BIN_NPM=`which npm`
export NPM_PATH="/usr/bin/npm"

rm -rf $NODE_PATH
rm -rf $NPM_PATH

if [ -f "${BIN_NODE}" ]; then
    /bin/ln -nsf ${BIN_NODE} $NODE_PATH
else
    /bin/ln -nsf $WHICH_BIN_NODE $NODE_PATH
fi

if [ -f "${BIN_NPM}" ]; then
    /bin/ln -nsf ${BIN_NPM} $NPM_PATH
else
    /bin/ln -nsf $WHICH_BIN_NPM $NPM_PATH
fi

npm install -g yarn
npm install -g webpack