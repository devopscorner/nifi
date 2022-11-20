FROM hashicorp/terraform:1.3.5

ENV PYTHONUNBUFFERED=1

RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

RUN pip3 --no-cache-dir install --upgrade awscli

ARG _AWS_ACCESS_KEY_ID
ARG _AWS_SECRET_ACCESS_KEY
ARG _AWS_DEFAULT_REGION

ENV AWS_ACCESS_KEY_ID  $_AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY $_AWS_SECRET_ACCESS_KEY
ENV AWS_DEFAULT_REGION  $_AWS_DEFAULT_REGION

RUN mkdir -p terraform
WORKDIR terraform

ENTRYPOINT ["terraform"]

