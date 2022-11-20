FROM alpine:3.16

ARG _AWS_ACCESS_KEY_ID
ARG _AWS_SECRET_ACCESS_KEY
ARG _AWS_DEFAULT_REGION

ENV AWS_ACCESS_KEY_ID  $_AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY $_AWS_SECRET_ACCESS_KEY
ENV AWS_DEFAULT_REGION  $_AWS_DEFAULT_REGION

ENV BUILD_PACKAGES \
  openssh-client \
  ansible \
  git

# If installing ansible@testing
#RUN \
#	echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> #/etc/apk/repositories

COPY requirements.txt requirements.txt
RUN set -x && \
    \
    echo "==> Adding build-dependencies..."  && \
    apk --update add --virtual build-dependencies \
      gcc \
      musl-dev \
      libffi-dev \
      openssl-dev \
      python3 && \
    \
    echo "==> Upgrading apk and system..."  && \
    apk update && apk upgrade && \
    \
    echo "==> Adding Python runtime..."  && \
    apk add --no-cache ${BUILD_PACKAGES} && \
    python3 -m ensurepip && pip3 install -U pip && \
    pip3 install --upgrade pip && \
    pip3 install -r requirements.txt && \
    \
    echo "==> Cleaning up..."  && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    \
    echo "==> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible /ansible && \
    echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts


ENV PYTHONPATH /ansible/lib
ENV PATH /ansible/bin:$PATH

RUN pip3 --no-cache-dir install --upgrade awscli boto3

COPY roles/ /ansible/roles/
COPY ansible.cfg /ansible/ansible.cfg

RUN ansible-galaxy install -r /ansible/roles/requirements.yml

WORKDIR /ansible

ENTRYPOINT ["ansible-playbook"]