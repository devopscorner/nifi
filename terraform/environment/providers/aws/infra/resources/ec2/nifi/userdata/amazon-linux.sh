#!/bin/sh

# ================================================================================================
#  INSTALL USER-DATA (AMAZON LINUX)
# ================================================================================================
export ANSIBLE_VERSION=2.12.2
export PACKER_VERSION=1.7.10
export TERRAFORM_VERSION=1.1.6
export TERRAGRUNT_VERSION=v0.36.1

export DOCKER_PATH="/usr/bin/docker"
export DOCKER_COMPOSE_PATH="/usr/bin/docker-compose"
export DOCKER_COMPOSE_VERSION="1.29.2"

sudo yum update
sudo yum install -y \
    git \
    bash \
    curl \
    wget \
    jq \
    nano \
    zip \
    unzip \
    tmux \
    mc \
    vim \
    ruby \
    python3 \
    python2.7

# ================================================================================================
#  INSTALL DOCKER (Amazon Linux)
# ================================================================================================
sudo amazon-linux-extras install docker

# ================================================================================================
#  INSTALL DOCKER-COMPOSE
# ================================================================================================
sudo curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m) -o $DOCKER_COMPOSE_PATH
sudo chmod +x /usr/bin/docker-compose

# install terraform
curl -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin &&
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&
    # install terragrunt
    curl -o /usr/local/bin/terragrunt \
        https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 &&
    chmod +x /usr/local/bin/terragrunt &&
    # install packer
    curl -o packer_${PACKER_VERSION}_linux_amd64.zip \
        https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip &&
    unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin &&
    rm -f packer_${PACKER_VERSION}_linux_amd64.zip

python3 -m pip install pip==21.3.1 &&
    pip3 install --upgrade pip cffi awscli &&
    # install ansible
    pip3 install --no-cache-dir ansible-core==${ANSIBLE_VERSION} \
        ansible-tower-cli==3.3.4 \
        PyYaml \
        Jinja2 \
        httplib2 \
        six \
        requests \
        boto3 \
        awscli

## install tfenv
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >>~/.bash_profile
ln -sf ~/.tfenv/bin/* /usr/local/bin
mkdir -p ~/.local/bin/
. ~/.profile
ln -sf ~/.tfenv/bin/* ~/.local/bin

##### CUSTOMIZE ~/.profile #####
echo '' >>~/.profile
echo '### Docker ###
export DOCKER_CLIENT_TIMEOUT=300
export COMPOSE_HTTP_TIMEOUT=300' >>~/.profile

##### CONFIGURE DOCKER #####
sudo usermod -a -G docker ec2-user

sudo ln -snf $DOCKER_PATH /usr/bin/dock
sudo ln -snf $DOCKER_COMPOSE_PATH /usr/bin/dcomp

sudo systemctl enable docker.service
sudo systemctl start docker.service

##### CONFIGURE CodeDeploy #####
# wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
# chmod +x ./install
# ./install auto
curl -s https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install | bash -s auto

## Set Locale
sudo echo 'LANG=en_US.utf-8' >>/etc/environment
sudo echo 'LC_ALL=en_US.utf-8' >>/etc/environment

## Adding Custom Sysctl
sudo echo 'vm.max_map_count=524288' >>/etc/sysctl.conf
sudo echo 'fs.file-max=131072' >>/etc/sysctl.conf

################################################

export NIFI_VERSION="1.18.0"
export NIFI_HOME="/home/ec2-user"
HOSTNAME=$(hostname)

NIFI_USER_AUTHORIZER='managed-authorizer'
NIFI_BOOTSTRAP_CONF="$NIFI_HOME/nifi-${NIFI_VERSION}/conf/bootstrap.conf"
NIFI_CONFIG_FILE="$NIFI_HOME/nifi-${NIFI_VERSION}/conf/nifi.properties"
NIFI_AUTH_Z_FILE="$NIFI_HOME/nifi-${NIFI_VERSION}/conf/authorizers.xml"
NIFI_HOST="nifi.awscb.id"
NIFI_PORT=8443

REGISTRY_AUTHORIZER='managed-authorizer'
REGISTRY_CONFIG_FILE="$NIFI_HOME/nifi-registry-${NIFI_VERSION}/conf/nifi-registry.properties"
REGISTRY_AUTH_Z_FILE="$NIFI_HOME/nifi-registry-${NIFI_VERSION}/conf/authorizers.xml"
REGISTRY_HOST="nifi-registry.awscb.id"
REGISTRY_PORT=18443

echo "//------------- Setup TLS/SSL -------------//"
$NIFI_HOME/nifi-toolkit-${NIFI_VERSION}/bin/tls-toolkit.sh standalone -n "localhost" -o $NIFI_HOME/nifi-toolkit-${NIFI_VERSION}/target \
    --subjectAlternativeNames "${HOSTNAME}","${NIFI_HOST}","${REGISTRY_HOST}"

cp $NIFI_HOME/nifi-toolkit-${NIFI_VERSION}/target/localhost/*.jks $NIFI_HOME/nifi-${NIFI_VERSION}/conf/
cp $NIFI_HOME/nifi-toolkit-${NIFI_VERSION}/target/localhost/*.jks $NIFI_HOME/nifi-registry-${NIFI_VERSION}/conf/

# Registry TLS/SSL setup
GENERATED_TLS=$NIFI_HOME/nifi-toolkit-${NIFI_VERSION}/target/localhost/nifi.properties

SECURITY_KEYSTORE="$(cat "${GENERATED_TLS}" | grep -E "nifi.security.keystore=" | cut -d'=' -f2)"
SECURITY_KEYSTORE_TYPE="$(cat "${GENERATED_TLS}" | grep -E "nifi.security.keystoreType=" | cut -d'=' -f2)"
SECURITY_KEYSTORE_PASSWD="$(cat "${GENERATED_TLS}" | grep -E "nifi.security.keystorePasswd=" | cut -d'=' -f2)"
SECURITY_KEYPASSWD="$(cat "${GENERATED_TLS}" | grep -E "nifi.security.keyPasswd=" | cut -d'=' -f2)"
SECURITY_TRUSTSTORE="$(cat "${GENERATED_TLS}" | grep -E "nifi.security.truststore=" | cut -d'=' -f2)"
SECURITY_TRUSTSTORE_TYPE="$(cat "${GENERATED_TLS}" | grep -E "nifi.security.truststoreType=" | cut -d'=' -f2)"
SECURITY_TRUSTSTORE_PASSWD="$(cat "${GENERATED_TLS}" | grep -E "nifi.security.truststorePasswd=" | cut -d'=' -f2)"

echo "//------------- Setup NiFi Repository -------------//"
mkfs -t ext4 /dev/nvme1n1
mkfs -t ext4 /dev/nvme2n1
mkfs -t ext4 /dev/nvme3n1
mkfs -t ext4 /dev/nvme4n1

mkdir -p $NIFI_HOME/nifi-${NIFI_VERSION}/content_repository
mkdir -p $NIFI_HOME/nifi-${NIFI_VERSION}/provenance_repository
mkdir -p $NIFI_HOME/nifi-${NIFI_VERSION}/flowfile_repository
mkdir -p /opt/data/docker

mount /dev/nvme1n1 $NIFI_HOME/nifi-${NIFI_VERSION}/content_repository
mount /dev/nvme2n1 $NIFI_HOME/nifi-${NIFI_VERSION}/provenance_repository
mount /dev/nvme3n1 $NIFI_HOME/nifi-${NIFI_VERSION}/flowfile_repository
mount /dev/nvme4n1 /opt/data

cp /etc/fstab /etc/fstab.backup

echo UUID=$(blkid -o value -s UUID /dev/nvme1n1) $NIFI_HOME/nifi-${NIFI_VERSION}/content_repository ext4 defaults,nofail 0 2 >>/etc/fstab
echo UUID=$(blkid -o value -s UUID /dev/nvme2n1) $NIFI_HOME/nifi-${NIFI_VERSION}/provenance_repository ext4 defaults,nofail 0 2 >>/etc/fstab
echo UUID=$(blkid -o value -s UUID /dev/nvme3n1) $NIFI_HOME/nifi-${NIFI_VERSION}/flowfile_repository ext4 defaults,nofail 0 2 >>/etc/fstab
echo UUID=$(blkid -o value -s UUID /dev/nvme4n1) /opt/data ext4 defaults,nofail 0 2 >>/etc/fstab

mount -a

## Change Permission ##
chown -R ec2-user:ec2-user $NIFI_HOME/nifi-${NIFI_VERSION}
chown -R ec2-user:ec2-user $NIFI_HOME/nifi-registry-${NIFI_VERSION}

mkdir -p /opt/data/docker/portainer2.9
mkdir -p /opt/data/docker/nifi-${NIFI_VERSION}
mkdir -p /opt/data/docker/nifi-registry-${NIFI_VERSION}
mkdir -p /opt/data/docker/postgresql12.8/pgdata
mkdir -p /opt/data/docker/postgresql14.6/pgdata
mkdir -p /opt/data/docker/openfortivpn22.04

chown -R ec2-user:ec2-user /opt/data/docker
chmod 777 /opt/data/docker

## Execute Install Libraries ##
# curl -s http://server/path/script.sh | bash -s arg1 arg2
curl -s https://raw.githubusercontent.com/devopscorner/nifi/master/scripts/get-jdbc-nifi-ec2-user.sh | bash

curl -o $NIFI_HOME/nifi-psql.yml \
    https://raw.githubusercontent.com/devopscorner/nifi/master/scripts/nifi-psql-images-ec2-user.yml

cd $NIFI_HOME && docker-compose -f nifi-psql.yml up -d