#!/usr/bin/env sh

### Symlink Node Binary ###
if [ -n "$1" ]; then
	export NODE_VERSION=$1
else
    export NODE_VERSION=${node_version:-16.10.3}
fi

export BIN_NODE="/root/.nvm/versions/node/v$NODE_VERSION/bin/node"
export WHICH_BINARY=`which node`
export NODE_PATH="/usr/bin/node"
rm -rf $NODE_PATH

if [ -f "$BIN_NODE" ]; then
    /bin/ln -nsf $BIN_NODE $NODE_PATH
else
    /bin/ln -nsf $WHICH_BINARY $NODE_PATH
fi
