#!/usr/bin/env sh

### Set Node Version ###
if [ -n "$1" ]; then
	export NODE_VERSION=$1
else
    export NODE_VERSION=${node_version:-16.10.3}
fi

### Update & Install Ubuntu Library ###
apt-get update
apt-get install -y \
  git \
  g++ \
  make \
  s3cmd

### Path NVM (NodeJS Version Manager) ###
export NVM_ROOT="$HOME/.nvm"

if [ -d "$NVM_ROOT" ]
then
  [ -s "$NVM_ROOT/nvm.sh" ] && . "$NVM_ROOT/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

/bin/bash -c "source ~/.nvm/nvm.sh && nvm install $NODE_VERSION && nvm alias default $NODE_VERSION && nvm use $NODE_VERSION"
