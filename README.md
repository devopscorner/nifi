# DevOpsCorner Nifi

![all contributors](https://img.shields.io/github/contributors/devopscorner/nifi)
![tags](https://img.shields.io/github/v/tag/devopscorner/nifi?sort=semver)
![download all](https://img.shields.io/github/downloads/devopscorner/nifi/total.svg)
![download latest](https://img.shields.io/github/downloads/devopscorner/nifi/0.10/total)
![view](https://views.whatilearened.today/views/github/devopscorner/nifi.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://raw.githubusercontent.com/devopscorner/nifi/master/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/nifi)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/nifi)
![forks](https://img.shields.io/github/forks/devopscorner/nifi)
![stars](https://img.shields.io/github/stars/devopscorner/nifi)
[![license](https://img.shields.io/github/license/devopscorner/nifi)](https://img.shields.io/github/license/devopscorner/nifi)

Container Nifi & Nifi Registry
- Provisioning with Terraform & Ansible
- EC2 Docker Compose & Kubernetes (EKS)
- Python3 & Libraries
- Unified Machine Learning (ML) Framework with [Ivy](https://github.com/unifyai/ivy)

---

## Introduction to NIFI

### NIFI Usecase

- Apache NiFi Tutorial: What is NiFi? Architecture & Installation (guru99.com), go to [this](https://www.guru99.com/apache-nifi-tutorial.html) link
- An Introduction to Apache NiFi, Use Cases and Best Practices (capgemini.github.io), go to [this](https://capgemini.github.io/development/introduction-nifi-best-practices) link
- Apache NiFi - Designing a flow for a real use case - Digital Hub, go to [this](https://scc-digitalhub.github.io/platform/nifi-tutorial-gtfs) link

## Available Tags

| Containers  | Pulls |
|-------------|-------|
| Container `devopscorner/nifi` [Tags](docs/README-Nifi.md) | [![nifi pulls](https://img.shields.io/docker/pulls/devopscorner/nifi.svg?label=nifi%20pulls&logo=docker)](https://hub.docker.com/r/devopscorner/nifi/) |
| Container `devopscorner/nifi-registry` [Tags](docs/README-Nifi-Registry.md) | [![nifi-registry pulls](https://img.shields.io/docker/pulls/devopscorner/nifi-registry.svg?label=nifi-registry%20pulls&logo=docker)](https://hub.docker.com/r/devopscorner/nifi-registry/) |

## Features

- Nifi (latest: 1.18.0)
- Nifi Registry (latest: 1.18.0)
- Python-3.10.8
- Python Libraries
  - cffi
  - awscli
  - PyYaml
  - Jinja2
  - httplib2
  - six
  - requests
  - boto3
  - pandas
  - beautifulsoup4
  - lxml
  - scrapy
  - SQLAlchemy
  - psycopg2-binary
  - ivy-core
  - checkov
- Unix Tools
  - git
  - curl
  - wget
  - vim
  - nano
  - zip
  - unzip
  - ping
  - netstat

---

## Prerequirements

- Ansible (`ansible`)
- Docker (`docker`)
- Docker Compose (`docker-compose`)
- AWS Cli version 2 (`aws`)
- Terraform Cli (`terraform`)
- Terraform Environment (`tfenv`)

## Documentation

- Index Documentation, go to [this](docs/README.md) link
- Ansible Documentation, go to [this](docs/README-Ansible.md) link
- Deploy Ansible Nifi, go to [this](docs/Deploy-Ansible.md) link
- Docker-Compose Nifi, go to [this](docs/Docker-Compose-Nifi.md) link
- EKS Nifi, go to [this](docs/EKS-Nifi.md) link

## Ansible Features

Ansible Services Pattern:

- Ansible Static & Dynamic Inventory

- Playbooks Group by Services
  - Datadog
  - Docker
  - Java
  - Nifi

- Roles by Ansible Galaxy
  - Adminer
  - Amazon-AWS
  - AWS-CLI
  - CertBot
  - Datadog
  - Docker
  - Java
  - Kubectl


## Terraform Features

Multi Environment Workspace:

- Remote State Terraform (S3 & DynamoDB)

- Core Infrastructure
  - VPC
  - Subnet EC2 & EKS
  - Security Group
  - NAT Gateway
  - Internet Gateway
  - VPC Peers Single CIDR
  - VPC Peers Multi CIDR

- Resources Other Infra
  - Budget
  - AWS Elastic Computing (EC2)
    - Jumphost
    - PostgreSQL (PSQL)
    - Nifi
  - Amazon Relational Database Service (RDS)

## Tested Environment

### Versioning

- Docker version

  ```
  docker -v
  ---
  Docker version 20.10.17-rd, build c2e4e01

  docker version
  ---
  Client:
    Version:           20.10.17-rd
    API version:       1.41
    Go version:        go1.17.11
    Git commit:        c2e4e01
    Built:             Fri Jul 22 18:31:17 2022
    OS/Arch:           darwin/amd64
    Context:           default
    Experimental:      true

  Server: Docker Desktop 4.14.1 (91661)
  Engine:
    Version:          20.10.21
    API version:      1.41 (minimum version 1.12)
    Go version:       go9.7
    Git commit:       3056208
    Built:            Tue Oct 25 18:00:19 2022
    OS/Arch:          linux/amd64
    Experimental:     false
  containerd:
    Version:          1.6.9
    GitCommit:        1c90a442489720eec95342e1789ee8a5e1b9536f
  runc:
    Version:          1.1.4
    GitCommit:        v1.1.4-0-g5fd4c4d
  docker-init:
    Version:          0.19.0
    GitCommit:        de40ad0
  ```

- Docker-Compose version

  ```
  docker-compose -v
  ---
  Docker Compose version v2.11.1
  ```

- AWS Cli

  ```
  aws --version
  ---
  nifi/2.8.7 Python/3.9.11 Darwin/21.6.0 exe/x86_64 prompt/off
  ```

- Terraform Cli

  ```
  terraform version
  ---
  Terraform v1.3.5
  on darwin_amd64
  - provider registry.terraform.io/hashicorp/aws v3.74.3
  - provider registry.terraform.io/hashicorp/local v2.1.0
  - provider registry.terraform.io/hashicorp/null v3.1.0
  - provider registry.terraform.io/hashicorp/random v3.1.0
  - provider registry.terraform.io/hashicorp/time v0.7.2
  ```

- Terraform Environment Cli

  ```
  tfenv -v
  ---
  tfenv 2.2.2
  ```

## Security Check

Make sure that you didn't push sensitive information in this repository

- [ ] AWS Credentials (AWS_ACCESS_KEY, AWS_SECRET_KEY)
- [ ] AWS Account ID
- [ ] AWS Resources ARN
- [ ] Username & Password
- [ ] Private (id_rsa) & Public Key (id_rsa.pub)
- [ ] DNS Zone ID
- [ ] APP & API Key

## Copyright

- Author: **Dwi Fahni Denni (@zeroc0d3)**
- Vendor: **DevOps Corner Indonesia (devopscorner.id)**
- License: **Apache v2**
