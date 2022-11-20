#!/usr/bin/env sh

# ================================================================================================
#  INSTALL ANSIBLE
# ================================================================================================
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
  git \
  bash \
  curl \
  wget \
  software-properties-common \
  openssh-server \
  openssh-client

apt-add-repository ppa:ansible/ansible
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
  ansible

for key in /etc/ssh/ssh_host_*_key.pub; do echo "localhost $(cat ${key})" >> /root/.ssh/known_hosts; done

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
  && python get-pip.py \
  && pip install coverage junit-xml

rm -f get-pip.py