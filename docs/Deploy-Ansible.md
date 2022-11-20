# DevOpsCorner Nifi - Ansible Deployment

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

## Jenkins

- Jenkins Master

```
ansible-playbook -i services/jenkins/ansible/inventory/staging/group_vars/inventory.ini -v playbooks/jenkins/service-jenkins-master.yaml \
      -e "deploy_hosts=jenkins-master" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -v
```

- Jenkins Worker

```
ansible-playbook -i services/jenkins/ansible/inventory/staging/group_vars/inventory.ini -v playbooks/jenkins/service-jenkins-worker.yaml \
      -e "deploy_hosts=jenkins-worker" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -v
```

---

## Multi Tags Deployment

- Multi Tags Deployment (from Jenkins playbooks)

```
ansible-playbook -i services/jenkins/ansible/inventory/staging/group_vars/inventory.ini -v playbooks/jenkins/service-jenkins-master.yaml \
      -e "deploy_hosts=jenkins-master" \
      -e "env=staging" \
      --private-key=keys/devopscorner-staging.pem \
      -K -v -t=docker,golang,java,nvm
```

---

## NIFI (without container)

- NIFI DEV

```
ansible-playbook -i services/nifi/ansible/inventory/dev/group_vars/inventory.ini playbooks/nifi/service-nifi.yaml \
      -e "deploy_hosts=nifi-public-ip" \
      -e "env=dev" \
      -e "remote_user=ubuntu" \
      -e "dataDir=/opt/nifi/config_resources/state/zookeeper" \
      --private-key=/opt/keyserver/devopscorner-staging.pem \
      -K -vv
```

- NIFI UAT

```
ansible-playbook -i services/nifi/ansible/inventory/uat/group_vars/inventory.ini playbooks/nifi/service-nifi.yaml \
      -e "deploy_hosts=nifi-public-ip" \
      -e "env=uat" \
      -e "remote_user=ubuntu" \
      -e "dataDir=/opt/nifi/config_resources/state/zookeeper" \
      --private-key=/opt/keyserver/devopscorner-staging.pem \
      -K -vv
```

- NIFI PROD

```
ansible-playbook -i services/nifi/ansible/inventory/prod/group_vars/inventory.ini playbooks/nifi/service-nifi.yaml \
      -e "deploy_hosts=nifi-public-ip" \
      -e "env=prod" \
      -e "remote_user=ubuntu" \
      -e "dataDir=/opt/nifi/config_resources/state/zookeeper" \
      --private-key=/opt/keyserver/devops-prod.pem \
      -K -vv
```

## NIFI (from container)

- NIFI Container DEV

```
ansible-playbook -i services/nifi/ansible/inventory/dev/group_vars/inventory.ini playbooks/nifi/service-nifi-container.yaml \
      -e "deploy_hosts=nifi-public-ip" \
      -e "env=dev" \
      -e "remote_user=ubuntu" \
      --private-key=/opt/keyserver/devopscorner-staging.pem \
      -K -vv
```

- NIFI Container UAT

```
ansible-playbook -i services/nifi/ansible/inventory/uat/group_vars/inventory.ini playbooks/nifi/service-nifi-container.yaml \
      -e "deploy_hosts=nifi-public-ip" \
      -e "env=uat" \
      -e "remote_user=ubuntu" \
      --private-key=/opt/keyserver/devopscorner-staging.pem \
      -K -vv
```

- NIFI Container PROD

```
ansible-playbook -i services/nifi/ansible/inventory/prod/group_vars/inventory.ini playbooks/nifi/service-nifi-container.yaml \
      -e "deploy_hosts=nifi-public-ip" \
      -e "env=prod" \
      -e "remote_user=ubuntu" \
      --private-key=/opt/keyserver/devops-prod.pem \
      -K -vv
```
