#!/usr/bin/env sh

# ================================================================================================
#  INSTALL GOLANG
# ================================================================================================
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install --no-install-recommends \
	g++ \
	gcc \
	libc6-dev \
	make \
	pkg-config

export GOLANG_VERSION=1.15.3
export goRelArch=amd64
export goRelSha256=010a88df924a81ec21b293b5da8f9b11c176d27c0ee3962dc1738d2352d3c02d

if ! [ "${GO_VERSION}" = "" ]
then
  GOLANG_VERSION=${GO_VERSION}
fi

set -eux;

url="https://golang.org/dl/go${GOLANG_VERSION}.linux-${goRelArch}.tar.gz";

curl -O $url
tar -xvf go${GOLANG_VERSION}.linux-${goRelArch}.tar.gz
cp -r go /usr/local

rm -rf /go
rm -f go${GOLANG_VERSION}.linux-${goRelArch}.tar.gz

mkdir -p $HOME/go

##### CUSTOMIZE ~/.profile #####
echo '' >> ~/.profile
echo '### GO-Lang $GOPATH ###
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.profile

# reload source ~/.profile
/bin/bash -c "source ~/.profile"

### Install Dep (Golang Package Manager) ###
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | bash