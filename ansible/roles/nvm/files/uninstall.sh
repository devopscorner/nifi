#!/usr/bin/env sh

### Remove all locked system ###
rm -rf /var/lib/dpkg/lock \
       /var/cache/apt/archives/lock

apt-get -y uninstall nodejs npm node
apt-get -y remove nodejs npm node

rm -rf /usr/local/bin/npm \
   /usr/local/share/man/man1/node \
   /usr/local/lib/dtrace/node.d \
   ~/.npm \
   ~/.node-gyp \
   /opt/local/bin/node \
   /opt/local/include/node \
   /opt/local/lib/node_modules
