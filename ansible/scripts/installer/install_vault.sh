#!/usr/bin/env sh

# ================================================================================================
#  INSTALL VAULT
# ================================================================================================
export DEBIAN_FRONTEND=noninteractive

export VAULT_VERSION="1.9.3"

if ! [ "${VT_VERSION}" = "" ]
then
  VAULT_VERSION=${VT_VERSION}
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

wget -nv https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -O /tmp/vault_${VAULT_VERSION}_linux_amd64.zip

cd /tmp
unzip -o vault_${VAULT_VERSION}_linux_amd64.zip
chmod +x /tmp/vault

mv /tmp/vault /usr/local/bin/vault
