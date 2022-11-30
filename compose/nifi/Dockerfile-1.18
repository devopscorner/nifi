FROM apache/nifi:${NIFI_VERSION:-1.18.0}

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL

ENV VENDOR="DevOpsCornerId"
ENV AUTHOR="DevOpsCorner.id <support@devopscorner.id>"
ENV IMG_NAME="nifi"
ENV IMG_VERSION="1.18.0"
ENV IMG_DESC="Docker Image Nifi 1.18.0"
ENV IMG_ARCH="amd64/x86_64"

ARG NIFI_VERSION=1.18.0
ARG BASE_URL=https://archive.apache.org/dist
ARG MIRROR_BASE_URL=https://downloads.apache.org
ARG DISTRO_PATH=1.18.0
ARG NIFI_BINARY_PATH=/nifi/1.18.0/nifi-1.18.0-bin.zip
ARG NIFI_TOOLKIT_BINARY_PATH=/nifi/1.18.0/nifi-toolkit-1.18.0-bin.zip

ENV NIFI_BASE_DIR=/opt/nifi
ENV NIFI_HOME=/opt/nifi/nifi-current
ENV NIFI_TOOLKIT_HOME=/opt/nifi/nifi-toolkit-current
ENV NIFI_PID_DIR=/opt/nifi/nifi-current/run
ENV NIFI_LOG_DIR=/opt/nifi/nifi-current/logs

ENV AWS_CLI_VERSION=2.9.1
ENV VERIFY_CHECKSUM=false

LABEL maintainer="$AUTHOR" \
      architecture="$IMG_ARCH" \
      nifi-version="$NIFI_VERSION" \
      org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.name="$IMG_NAME" \
      org.label-schema.description="$IMG_DESC" \
      org.label-schema.vcs-ref="$GIT_COMMIT" \
      org.label-schema.vcs-url="$GIT_URL" \
      org.label-schema.vendor="$VENDOR" \
      org.label-schema.version="$BUILD_VERSION" \
      org.label-schema.schema-version="$IMG_VERSION" \
      org.opencontainers.image.authors="$AUTHOR" \
      org.opencontainers.image.description="$IMG_DESC" \
      org.opencontainers.image.vendor="$VENDOR" \
      org.opencontainers.image.version="$IMG_VERSION" \
      org.opencontainers.image.revision="$GIT_COMMIT" \
      org.opencontainers.image.created="$BUILD_DATE" \
      fr.hbis.docker.base.build-date="$BUILD_DATE" \
      fr.hbis.docker.base.name="$IMG_NAME" \
      fr.hbis.docker.base.vendor="$VENDOR" \
      fr.hbis.docker.base.version="$BUILD_VERSION"

COPY rootfs /

ENV DEBIAN_FRONTEND noninteractive

USER root
RUN apt-get -o APT::Sandbox::User=root update; sync
RUN apt-get install -y \
      git \
      curl \
      zip \
      unzip \
      wget; sync

RUN apt-get install -y \
      bash \
      jq \
      apt-transport-https \
      ca-certificates \
      openssl \
      openssh-server \
      openssh-client \
      net-tools \
      vim-tiny \
      telnet \
      nano \
      libffi-dev \
      bzip2-dev \
      python3-minimal \
      python3-distutils \
      python3-pip \
      python3-apt \
      iputils-ping; sync

# =================== #
#  Install AWSCli v2  #
# =================== #
# RUN curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip -o awscliv2.zip &&\
#       unzip awscliv2.zip; sync &&\
#       ./aws/install --bin-dir /usr/local/bin/; sync
COPY --from=devopscorner/aws-cli:latest /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=devopscorner/aws-cli:latest /usr/local/bin/ /usr/local/bin/

# ========================= #
# Install Python Libraries  #
# ========================= #
RUN python3 -m pip install pip &&\
      pip3 install --upgrade pip==22.3.1 cffi &&\
      pip3 install --no-cache-dir \
      PyYaml \
      Jinja2 \
      httplib2 \
      six \
      requests \
      boto3 \
      pandas==1.3.5 \
      beautifulsoup4==4.9.3 \
      lxml==4.6.3 \
      scrapy==2.6.2 \
      SQLAlchemy==1.4.43 \
      psycopg2-binary \
      ivy-core &&\
      # setup root .ssh directory
      mkdir -p /root/.ssh &&\
      chmod 0700 /root/.ssh &&\
      chown -R root. /root/.ssh; sync

RUN chmod +x /tmp/*.sh

RUN apt-get clean; sync

WORKDIR /opt/nifi/nifi-current

EXPOSE 22 8000 8080 8443 10000
