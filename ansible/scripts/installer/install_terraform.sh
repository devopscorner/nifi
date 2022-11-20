#!/usr/bin/env sh

# ================================================================================================
#  INSTALL TERRAFORM
# ================================================================================================
export DEBIAN_FRONTEND=noninteractive

export TERRAFORM_VERSION="1.1.6"

if ! [ "${TF_VERSION}" = "" ]
then
  TERRAFORM_VERSION=${TF_VERSION}
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

wget -nv https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

cd /tmp
unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip
chmod +x /tmp/terraform

mv /tmp/terraform /usr/local/bin/terraform
