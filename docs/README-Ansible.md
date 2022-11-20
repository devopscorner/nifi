# DevOpsCorner Nifi - Ansible

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

## Folder Structure

```
.
├── README.md
├── ansible.cfg
├── keys
│   ├── devopscorner-prod.pem
│   └── devopscorner-staging.pem
├── main.go
├── playbooks
│   ├── datadog
│   ├── docker
│   ├── java
│   ├── jenkins
│   │   ├── service-jenkins-master.yaml
│   │   └── service-jenkins-master.yaml
│   ├── nifi
│   └── nvm
├── requirements.txt
├── roles
│   ├── adminer
│   ├── amazon-aws
│   ├── ansible-pretasks
│   ├── apt-clear-cache
│   ├── aws-cli
│   ├── certbot
│   ├── common
│   ├── datadog
│   ├── docker
│   ├── java
│   ├── jenkins
│   ├── nifi
│   ├── nvm
│   └── requirements.yaml
├── scripts
│   └── installer
└── services
    ├── nifi
    │   ├── ansible
    │   │   └── inventory
    │   │       ├── import_playbooks.yaml
    │   │       ├── prod
    │   │       │   ├── group_vars
    │   │       │   │   ├── all.yaml
    │   │       │   │   ├── inventory.ini
    │   │       │   │   └── local.yaml
    │   │       │   └── host_vars
    │   │       └── staging
    │   │           ├── group_vars
    │   │           │   ├── all.yaml
    │   │           │   ├── inventory.ini
    │   │           │   ├── local.yaml
    │   │           │   └── metadata_nifi.yaml
    │   │           └── host_vars
    │   └── terraform
    └── jenkins
        ├── ansible
        │   └── inventory
        │       ├── import_playbooks.yaml
        │       ├── prod
        │       │   ├── group_vars
        │       │   │   ├── all.yaml
        │       │   │   ├── inventory.ini
        │       │   │   └── local.yaml
        │       │   └── host_vars
        │       └── staging
        │           ├── group_vars
        │           │   ├── all.yaml
        │           │   ├── inventory.ini
        │           │   ├── local.yaml
        │           │   ├── metadata_jenkins_master.yaml
        │           │   └── metadata_jenkins_worker.yaml
        │           └── host_vars
        └── terraform
```

## Ansible Libraries

1. Install python-pip

   ```
   sudo apt install python-pip
   ```

2. Suggested to using virtualenv, skip if you sure what you are doing,

   ```
   sudo pip install virtualenv && virtualenv ~/venv && source ~/venv/bin/activate
   ```

3. In root of `devopscorner-nifi` directory.

   ```
   cd devopscorner-nifi && pip install -r requirements.txt
   ```

4. Install ansible galaxy roles

   ```
   cd devopscorner-nifi && ansible-galaxy install -r roles/requirements.yml
   ```


## Deploy by Services

### Jenkins Master

- Setup host target
  ```
  {{ run_type }}/{{ microservice_name }}/ansible/inventory/{{ env }}/group_vars/inventory.ini
  ```
- Setup variables deployment
  ```
  services/jenkins/ansible/inventory/{{ env }}/group_vars/metadata_jenkins_master.yaml
  ```
- Deploy cli jenkins master
  ```
  run_type           : services
  microservice_name  : jenkins
  env                : staging

  ansible-playbook -i {{ run_type }}/{{ microservice_name }}/ansible/inventory/{{ env }}/group_vars/inventory.ini -v playbooks/{{ services }}/service-jenkins-master.yaml \
      -e "deploy_hosts=jenkins-master" \
      -e "run_type=services" \
      -e "microservice_name=jenkins" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -vvv

  ---

  ansible-playbook -i services/jenkins/ansible/inventory/staging/group_vars/inventory.ini -v playbooks/jenkins/service-jenkins-master.yaml \
      -e "deploy_hosts=jenkins-master" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -vvv
  ```

### Jenkins Worker

- Setup host target
  ```
  {{ run_type }}/{{ microservice_name }}/ansible/inventory/{{ env }}/group_vars/inventory.ini
  ```
- Setup variables deployment
  ```
  services/jenkins/ansible/inventory/{{ env }}/group_vars/metadata_jenkins_worker.yaml
  ```
- Deploy cli jenkins worker
  ```
  run_type          : services
  microservice_name  : jenkins
  env                : staging

  ansible-playbook -i {{ run_type }}/{{ microservice_name }}/ansible/inventory/{{ env }}/group_vars/inventory.ini -v playbooks/{{ services }}/service-jenkins-worker.yaml \
      -e "deploy_hosts=jenkins-worker" \
      -e "run_type=services" \
      -e "microservice_name=jenkins" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -vvv

  ---

  ansible-playbook -i services/jenkins/ansible/inventory/staging/group_vars/inventory.ini -v playbooks/jenkins/service-jenkins-worker.yaml \
      -e "deploy_hosts=jenkins-worker" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -vvv
  ```

### Nifi

- Setup host target
  ```
  {{ run_type }}/{{ microservice_name }}/ansible/inventory/{{ env }}/group_vars/inventory.ini
  ```
- Setup variables deployment
  ```
  services/nifi/ansible/inventory/{{ env }}/group_vars/metadata_nifi.yaml
  ```
- Deploy cli nifi
  ```
  run_type           : services
  microservice_name  : nifi
  env                : staging

  ansible-playbook -i {{ run_type }}/{{ microservice_name }}/ansible/inventory/{{ env }}/group_vars/inventory.ini -v playbooks/{{ services }}/service-nifi.yaml \
      -e "deploy_hosts=nifi-public" \
      -e "run_type=services" \
      -e "microservice_name=nifi" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -vvv

  ---

  ansible-playbook -i services/nifi/ansible/inventory/staging/group_vars/inventory.ini -v playbooks/nifi/service-nifi.yaml \
      -e "deploy_hosts=nifi-public" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -vvv
  ```

## Checking Ansible Inventories

```
ansible-inventory --list -i {{ run_type }}/{{ microservice_name }}/ansible/inventory/{{ env }}/group_vars/inventory.ini
---
ansible-inventory --list -i services/nifi/ansible/inventory/staging/group_vars/inventory.ini
```

## Dynamic Inventory

- Download Dynamic Ansible Inventory
  ```
  https://github.com/ansible/ansible/tree/release1.5.0/plugins/inventory
  ```

- Setup Dynamic Inventory
  ```
  ## ansible.cfg
  ---
  [inventory]
  enable_plugins = aws_ec2

  [defaults]
  inventory = ./inventory/aws_ec2.yaml

  [profile dev]
  aws_access_key_id = AWS_ACCESS_KEY
  aws_secret_access_key = AWS_SECRET_KEY

  [profile prod]
  aws_access_key_id = AWS_ACCESS_KEY
  aws_secret_access_key = AWS_SECRET_KEY

  ###################################################

  ## inventory/aws_ec2.yaml
  ---
  plugin: aws_ec2

  aws_access_key: <YOUR-AWS-ACCESS-KEY-HERE>
  aws_secret_key: <YOUR-AWS-SECRET-KEY-HERE>

  regions:
    - us-west-2

  keyed_groups:
    - key: tags
      prefix: tag
    - prefix: instance_type
      key: instance_type
    - key: placement.region
      prefix: aws_region
  ```

- List Dynamic Inventory
  ```
  ################
  ## Using Graph #
  ################
  ansible-inventory --graph

  #############################
  ## Inventory Script Python ##
  #############################
  ./inventory/aws/ec2.py - - list
  ```

- List Host Inventory
  ```
  ansible all — — list-hosts
  ```

- Added Private Key Configuraton to `ansible.cfg`
  ```
  [default]
  private_key_file= /opt/keyserver/devopscorner-staging.pem
  ```

- Deploy cli jenkins master
  ```
  ansible-playbook -i inventory/ec2.py -v playbooks/jenkins/service-jenkins-master.yaml \
      -e "deploy_hosts=jenkins-master" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -vvv
  ```

- Deploy cli jenkins worker
  ```
  ansible-playbook -i inventory/ec2.py -v playbooks/jenkins/service-jenkins-worker.yaml \
      -e "deploy_hosts=jenkins-worker" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -vvv
  ```

- Deploy cli nifi
  ```
  ansible-playbook -i inventory/ec2.py -v playbooks/nifi/service-nifi.yaml \
      -e "deploy_hosts=nifi-jenkins-master" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -vvv
  ```

## Deploy with Spesific Tags

- Deploy Single Tags for Jenkins Master
  ```
  ansible-playbook -i services/jenkins/ansible/inventory/staging/group_vars/inventory.ini -v playbooks/jenkins/service-jenkins-master.yaml \
      -e "deploy_hosts=jenkins-master" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -vvv -t=nifi
  ```

- Deploy Multi Tags for Jenkins Master
  ```
  ansible-playbook -i services/jenkins/ansible/inventory/staging/group_vars/inventory.ini -v playbooks/jenkins/service-jenkins-master.yaml \
      -e "deploy_hosts=jenkins-master" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -vvv -t=java,nifi,nvm
  ```