#!/usr/bin/env sh

export DEBIAN_FRONTEND=noninteractive

# apt-key adv --recv-key 40976EAF437D05B5
# apt-key adv --recv-key 3B4FE6ACC0B21F32

apt-get -qq update
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
  git \
  awscli
