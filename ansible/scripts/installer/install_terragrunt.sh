#!/usr/bin/env sh

# ================================================================================================
#  INSTALL TERRAGRUNT
# ================================================================================================
export DEBIAN_FRONTEND=noninteractive

export TERRAGRUNT_VERSION="0.36.1"

if ! [ "${TG_VERSION}" = "" ]
then
  TERRAGRUNT_VERSION=${TG_VERSION}
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

wget -q -nv https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -O /usr/local/bin/terragrunt

chmod +x /usr/local/bin/terragrunt
