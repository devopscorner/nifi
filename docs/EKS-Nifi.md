# DevOpsCorner Nifi - EKS

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
- AWS Cli
- DockerHub Authentification
- ECR Authentification
- Helm
- Helm Template
- Helmfile

## How-to-Run

- Build Container
  - Nifi
    ```
    ## Goto compose/nifi folder
    cd compose/nifi
    docker build -f Dockerfile-1.18 -t devopscorner/nifi:latest .

    docker build -f Dockerfile-1.18 -t devopscorner/nifi:1.18.0 .

    docker build -f Dockerfile-1.17 -t devopscorner/nifi:1.17.0 .

    docker build -f Dockerfile-1.16 -t devopscorner/nifi:1.16.3 .
    ```

  - Nifi Registry
    ```
    ## Goto compose/nifi-registry folder
    cd compose/nifi-registry
    docker build -f Dockerfile-1.18 -t devopscorner/nifi-registry:latest .

    docker build -f Dockerfile-1.18 -t devopscorner/nifi-registry:1.18.0 .

    docker build -f Dockerfile-1.17 -t devopscorner/nifi-registry:1.17.0 .

    docker build -f Dockerfile-1.16 -t devopscorner/nifi-registry:1.16.3 .
    ```

- Tag Container
  - Nifi
    ```
    docker tag devopscorner/nifi:latest evopscorner/nifi:1.18

    docker tag devopscorner/nifi:1.17.0 evopscorner/nifi:1.17

    docker tag devopscorner/nifi:1.16.3 evopscorner/nifi:1.16
    ```

  - Nifi Registry
    ```
    docker tag devopscorner/nifi-registry:latest evopscorner/nifi-registry:1.18

    docker tag devopscorner/nifi-registry:1.17.0 evopscorner/nifi-registry:1.17

    docker tag devopscorner/nifi-registry:1.16.3 evopscorner/nifi-registry:1.16
    ```

- Push Container

  - Nifi
    ```
    docker push devopscorner/nifi:1.18 && docker push devopscorner/nifi:1.18.0

    docker push devopscorner/nifi:1.17 && docker push devopscorner/nifi:1.17.0

    docker push devopscorner/nifi:1.16 && docker push devopscorner/nifi:1.16.3

    docker push devopscorner/nifi:latest
    ```

  - Nifi Registry

    ```
    docker push devopscorner/nifi-registry:1.18 && docker push devopscorner/nifi-registry:1.18.0

    docker push devopscorner/nifi-registry:1.17 && docker push devopscorner/nifi-registry:1.17.0

    docker push devopscorner/nifi-registry:1.16 && docker push devopscorner/nifi-registry:1.16.3

    docker push devopscorner/nifi-registry:latest
    ```

- Provisioning EKS Cluster, detail step see [this](https://github.com/devopscorner/terraform-infra/blob/master/docs/DEMO.md) docs

- Deploy Helm Template, detail step see [this](https://github.com/devopscorner/devopscorner-helm) repository

- Create Helm Values
  - Nifi
    ```
    cd helm/helmfile
    vi nifi-values.yml
    ```
  - Nifi Registry
    ```
    cd helm/helmfile
    vi nifi-registry-values.yml
    ```

- Deploy Helm Values
  - Update Kubernetes Config (Get Kubernetes Context)
    ```
    aws eks update-kubeconfig --region ap-southeast-1 --name devopscorner-staging
    ```
  - Use Kubernetes Config Context
    ```
    kubectl config use-context arn:aws:eks:ap-southeast-1:${ACCOUNT_ID}:cluster/${EKS_CLUSTER}
    ```
  - Helm Repo Update
    ```
    helm repo update
    ```
  - Deploy with Helmfile
    ```
    ## Goto helm/helmfile folder
    cd helm/helmfile
    helmfile -f helm-template.yml apply
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
