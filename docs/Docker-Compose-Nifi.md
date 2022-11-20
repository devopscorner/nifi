# DevOpsCorner Nifi - Docker Compose

![all contributors](https://img.shields.io/github/contributors/devopscorner/nifi)
![tags](https://img.shields.io/github/v/tag/devopscorner/nifi?sort=semver)
![download all](https://img.shields.io/github/downloads/devopscorner/nifi/total.svg)
![view](https://views.whatilearened.today/views/github/devopscorner/nifi.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://github.com/devopscorner/nifi/blob/master/clone.json?raw=True&logo=github)
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

## Prerequirements

- Docker
- Docker-Compose

## How-to-Run

- With Script
  ```
  ./run-docker.sh
  ```

- Running Docker-Compose with Spesific File
  ```
  ## Goto compose folder
  cd compose
  docker-compose -f nifi-psql.yml up -d
  ```

- Stop
  ```
  ## Goto compose folder
  cd compose
  docker-compose -f nifi-psql.yml stop
  ```

- Remove
  ```
  ## Goto compose folder
  cd compose
  docker-compose -f nifi-psql.yml down
  ```

## Tested Environment

### Versioning

- Docker version

  ```
  docker version

  Client:
    Cloud integration: v1.0.22
    Version:           20.10.17-rd
    API version:       1.41
    Go version:        go1.17.11
    Git commit:        c2e4e01
    Built:             Fri Jul 22 18:31:17 2022
    OS/Arch:           darwin/amd64
    Context:           default
    Experimental:      true
  ```

- Docker-Compose version

  ```
  docker-compose -v
  ---
  Docker Compose version v2.11.1
  ```
