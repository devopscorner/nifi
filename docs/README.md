# DevOpsCorner Nifi

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

## INDEX

- Terraform Plan Inventory
  - [Terraform Plan - Core Staging](terraform-plan-core-staging.md)
  - [Terraform Plan - Core Prod](terraform-plan-core-prod.md)
  - [Terraform Plan - EKS Staging](terraform-plan-eks-staging.md)
  - [Terraform Plan - EKS Prod](terraform-plan-eks-prod.md)
  - [Terraform Security Analysis - Core Staging](terraform-security-analysis-core-staging.md)
  - [Terraform Security Analysis - Core Prod](terraform-security-analysis-core-prod.md)
  - [Terraform Security Analysis - EKS Staging](terraform-security-analysis-eks-staging.md)
  - [Terraform Security Analysis - EKS Prod](terraform-security-analysis-eks-prod.md)
  - [Terraform Infra Costing - Core Staging](terraform-infracost-core-staging.md)
  - [Terraform Infra Costing - Core Prod](terraform-infracost-core-prod.md)
  - [Terraform Infra Costing - EKS Staging](terraform-infracost-eks-staging.md)
  - [Terraform Infra Costing - EKS Prod](terraform-infracost-eks-prod.md)

- Terraform State Inventory
  - [Core Infrastructure Staging](terraform-state-core-infra-staging.md)
  - [Core Infrastructure Prod](terraform-state-core-infra-prod.md)
  - [EKS Staging](terraform-state-eks-staging.md)
  - [EKS Production](terraform-state-eks-prod.md)

- Terraform Docs Generator with `terraform-docs`, download [this](https://github.com/terraform-docs/terraform-docs/) binary
  - [Terraform Infra Core](README-Terraform-Infra-Core.md)
    ```
    cd terraform/environment/providers/aws/infra/core

    touch ../../../../../../docs/README-Terraform-Infra-Core.md

    terraform-docs markdown table --output-file ../../../../../../docs/README-Terraform-Infra-Core.md --output-mode inject .
    ```

  - [Terraform Infra TFState](README-Terraform-Infra-TFState.md)
    ```
    cd terraform/environment/providers/aws/infra/tfstate

    touch ../../../../../../docs/README-Terraform-Infra-TFState.md

    terraform-docs markdown table --output-file ../../../../../../docs/README-Terraform-Infra-TFState.md --output-mode inject .
    ```

  - [Terraform Infra Resources Budget](README-Terraform-Infra-Resources-Budget.md)
    ```
    cd terraform/environment/providers/aws/infra/resources/budget

    touch ../../../../../../../docs/README-Terraform-Infra-Resources-Budget.md

    terraform-docs markdown table --output-file ../../../../../../../docs/README-Terraform-Infra-Resources-Budget.md --output-mode inject .
    ```

  - [Terraform Infra Resources EC2 Jumphost](README-Terraform-Infra-Resources-EC2-Jumphost.md)
    ```
    cd terraform/environment/providers/aws/infra/resources/ec2/jumphost

    touch ../../../../../../../../../docs/README-Terraform-Infra-Resources-EC2-Jumphost.md

    terraform-docs markdown table --output-file ../../../../../../../../../docs/README-Terraform-Infra-Resources-EC2-Jumphost.md --output-mode inject .
    ```

  - [Terraform Infra Resources EC2 Nifi](README-Terraform-Infra-Resources-EC2-Nifi.md)
    ```
    cd terraform/environment/providers/aws/infra/resources/ec2/nifi

    touch ../../../../../../../../../docs/README-Terraform-Infra-Resources-EC2-Nifi.md

    terraform-docs markdown table --output-file ../../../../../../../../../docs/README-Terraform-Infra-Resources-EC2-Nifi.md --output-mode inject .
    ```

  - [Terraform Infra Resources EC2 PSQL](README-Terraform-Infra-Resources-EC2-PSQL.md)
    ```
    cd terraform/environment/providers/aws/infra/resources/ec2/psql

    touch ../../../../../../../../../docs/README-Terraform-Infra-Resources-EC2-PSQL.md

    terraform-docs markdown table --output-file ../../../../../../../../../docs/README-Terraform-Infra-Resources-EC2-PSQL.md --output-mode inject .
    ```

  - [Terraform Infra Resources EKS Nifi](README-Terraform-Infra-Resources-EKS-Nifi.md)
    ```
    cd terraform/environment/providers/aws/infra/resources/eks

    touch ../../../../../../../docs/README-Terraform-Infra-Resources-EKS-Nifi.md

    terraform-docs markdown table --output-file ../../../../../../../docs/README-Terraform-Infra-Resources-EKS-Nifi.md --output-mode inject .
    ```

  - [Terraform Infra Resources RDS NifiDB](README-Terraform-Infra-Resources-RDS-NifiDB.md)
    ```
    cd terraform/environment/providers/aws/infra/resources/rds/nifidb

    touch ../../../../../../../../docs/README-Terraform-Infra-Resources-EC2-Nifi.md

    terraform-docs markdown table --output-file ../../../../../../../../docs/README-Terraform-Infra-Resources-EC2-Nifi.md --output-mode inject .
    ```


- Ansible Nifi
  - [Ansible Setup](README-Ansible.md)
  - [Ansible Deployment](Deploy-Ansible.md)

- Container Nifi
  - [Docker Compose](Docker-Compose-Nifi.md)
  - [Kubernetes (EKS) Nifi](EKS-Nifi.md)