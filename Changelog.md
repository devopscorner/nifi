# DevOpsCorner Nifi - Changelog History

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
## Version 0.9

- Added FortiClient VPN container for multinetwork bridge (cloud network & onprem)

---
## Version 0.8

- Upgrade PostgreSQL nifi container to 14.6
- Fixing partition lifecycle terraform nifi
- Update setup bootstrap userdata ec2 nifi

---
## Version 0.7

- Refactoring remove unused scripts

---
## Version 0.6

- Refactoring path images from docker-compose nifi
- Refactoring user-data for spesific operating system (ubuntu / aws-linux)
- Added documentation assets nifi configuration
- Setup additional volume (EBS attachment) for spesific Nifi folder & docker container

---
## Version 0.5

- Added Ansible Service Pattern for Provisioning Nifi with VM (Virtual Machine) / Instances EC2
- Added Docker-Compose for Nifi & Nifi Registry
- Added Terraform Scripts
  - Core
  - Resources
    - Budget
    - EC2
      - Nifi
      - Jumphost
      - PSQL
    - RDS
  - TFState
- Upgrade EKS version 1.22 from 1.19
- Added New Helm Template Global
- Added New Helm Values using `helmfile`
- Added Documentation for Ansible Nifi Deployment
- Added Documentation for Nifi Terraform
  - Plan
  - Cost Review (`infracost`)
  - Security Analysis
    - `checkov`
    - `terrascan`
    - `tfsec`
