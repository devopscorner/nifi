#!/usr/bin/env sh

# ================================================================================================
#  INSTALL NFS SERVER
# ================================================================================================
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install --no-install-recommends \
	mc \
    nfs-kernel-server
