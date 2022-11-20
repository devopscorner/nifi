#!/usr/bin/env sh

# ================================================================================================
#  INSTALL NFS CLIENT
# ================================================================================================
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install --no-install-recommends \
	mc \
    nfs-common
