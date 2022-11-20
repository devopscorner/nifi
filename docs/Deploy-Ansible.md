# POC Deployment

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
