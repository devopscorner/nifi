# -----------------------------------------------------------------------------
#  MAKEFILE RUNNING COMMAND
# -----------------------------------------------------------------------------
#  Author     : DevOps Engineer (support@devopscorner.id)
#  License    : Apache v2
# -----------------------------------------------------------------------------
# Notes:
# use [TAB] instead [SPACE]

export PATH_APP=`pwd`
export PATH_WORKSPACE="src"
export PATH_SCRIPT="scripts"
export PATH_COMPOSE="."
export PATH_DOCKER="."
export PROJECT_NAME="nifi"
export TF_PATH="terraform/environment/providers/aws/infra"
export TF_CORE="$(TF_PATH)/core"
export TF_RESOURCES="$(TF_PATH)/resources"
export TF_STATE="$(TF_PATH)/tfstate"

export TF_MODULES="terraform/modules/providers/aws"

export CI_REGISTRY     ?= $(ARGS).dkr.ecr.ap-southeast-1.amazonaws.com
export CI_PROJECT_PATH ?= devopscorner
export CI_PROJECT_NAME ?= nifi

IMAGE   = $(CI_REGISTRY)/${CI_PROJECT_PATH}/${CI_PROJECT_NAME}
DIR     = $(shell pwd)
VERSION ?= 1.3.0

export BASE_IMAGE=ubuntu
export UBUNTU_VERSION=22.04
export NIFI_VERSION=1.18.0
export NIFI_REGISTRY_VERSION=1.18.0

# =============== #
#   GET MODULES   #
# =============== #
.PHONY: sub-officials sub-community sub-all
sub-officials:
	@echo "=============================================================="
	@echo " Task      : Get Official Submodules "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@mkdir -p $(TF_MODULES)/officials
	@cd $(PATH_APP) && ./get-officials.sh

sub-community:
	@echo "=============================================================="
	@echo " Task      : Get Community Submodules "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@mkdir -p $(TF_MODULES)/community
	@cd $(PATH_APP) && ./get-community.sh

sub-all:
	@make sub-officials
	@echo ''
	@make sub-community
	@echo ''
	@echo '---'
	@echo '- ALL DONE -'

# ==================== #
#   CLONE REPOSITORY   #
# ==================== #
.PHONY: git-clone
git-clone:
	@echo "=============================================================="
	@echo " Task      : Clone Repository Sources "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@./git-clone.sh $(SOURCE) $(TARGET)
	@echo '- DONE -'

# =================== #
#   BUILD CONTAINER   #
# =================== #
.PHONY: dockerhub-build-nifi dockerhub-build-nifi-registry ecr-build-nifi ecr-build-nifi-registry

# ./dockerhub-build.sh Dockerfile [DOCKERHUB_IMAGE_PATH] [alpine|ubuntu|codebuild] [version|latest|tags] [custom-tags]
dockerhub-build-nifi:
	@echo "=============================================================="
	@echo " Task      : Create Container Image Nifi (DockerHub) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./dockerhub-build.sh Dockerfile-Nifi devopscorner/nifi ubuntu ${NIFI_VERSION}
	@echo '- DONE -'

dockerhub-build-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Create Container Image Nifi Registry (DockerHub) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./dockerhub-build.sh Dockerfile-Nifi-Registry devopscorner/nifi-registry ubuntu ${NIFI_REGISTRY_VERSION}
	@echo '- DONE -'

# ./ecr-build.sh [AWS_ACCOUNT] Dockerfile [ECR_PATH] [alpine|ubuntu|codebuild] [version|latest|tags] [custom-tags]
ecr-build-nifi:
	@echo "=============================================================="
	@echo " Task      : Create Container Image Nifi (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-build.sh $(ARGS) Dockerfile-Nifi $(CI_PATH) ubuntu ${NIFI_VERSION}
	@echo '- DONE -'

ecr-build-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Create Container Image Nifi Registry (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-build.sh $(ARGS) Dockerfile-Nifi-Registry $(CI_PATH) ubuntu ${NIFI_REGISTRY_VERSION}
	@echo '- DONE -'

# ================== #
#   TAGS CONTAINER   #
# ================== #
.PHONY: dockerhub-tag-nifi dockerhub-tag-nifi-registry ecr-tag-nifi ecr-tag-nifi-registry

# ./dockerhub-tag.sh [DOCKERHUB_IMAGE_PATH] [alpine|ubuntu] [version|latest|tags] [custom-tags]
dockerhub-tag-nifi:
	@echo "=============================================================="
	@echo " Task      : Set Tags Image Nifi (DockerHub) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./dockerhub-tag.sh $(CI_PATH) ubuntu ${NIFI_VERSION}
	@echo '- DONE -'

dockerhub-tag-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Set Tags Image Nifi Registry (DockerHub) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./dockerhub-tag.sh $(CI_PATH) ubuntu ${NIFI_REGISTRY_VERSION}
	@echo '- DONE -'

# ./ecr-tag.sh [AWS_ACCOUNT] [ECR_PATH] [alpine|ubuntu] [version|latest|tags] [custom-tags]
ecr-tag-nifi:
	@echo "=============================================================="
	@echo " Task      : Set Tags Image Nifi (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-tag.sh $(ARGS) $(CI_PATH) ubuntu ${NIFI_VERSION}
	@echo '- DONE -'

ecr-tag-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Set Tags Image Nifi Registry (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-tag.sh $(ARGS) $(CI_PATH) ubuntu ${NIFI_REGISTRY_VERSION}
	@echo '- DONE -'

# ================== #
#   PUSH CONTAINER   #
# ================== #
.PHONY: dockerhub-push-nifi dockerhub-push-nifi-registry ecr-push-nifi ecr-push-nifi-registry

# ./dockerhub-push.sh [DOCKERHUB_IMAGE_PATH] [alpine|ubuntu|codebuild|version|latest|tags|custom-tags]
dockerhub-push-nifi:
	@echo "=============================================================="
	@echo " Task      : Push Container Image Nifi (DockerHub) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./dockerhub-push.sh $(CI_PATH) ubuntu
	@sh ./dockerhub-push.sh $(CI_PATH) latest
	@sh ./dockerhub-push.sh $(CI_PATH) ${NIFI_VERSION}
	@echo '- DONE -'

dockerhub-push-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Push Container Image Nifi Registry (DockerHub) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./dockerhub-push.sh $(CI_PATH) ubuntu
	@sh ./dockerhub-push.sh $(CI_PATH) latest
	@sh ./dockerhub-push.sh $(CI_PATH) ${NIFI_REGISTRY_VERSION}
	@echo '- DONE -'

# ./ecr-push.sh [AWS_ACCOUNT] [ECR_PATH] [alpine|ubuntu|codebuild|version|latest|tags|custom-tags]
ecr-push-nifi:
	@echo "=============================================================="
	@echo " Task      : Push Container Image Nifi (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-push.sh $(ARGS) $(CI_PATH) ubuntu
	@sh ./ecr-push.sh $(ARGS) $(CI_PATH) latest
	@sh ./ecr-push.sh $(ARGS) $(CI_PATH) ${NIFI_VERSION}
	@echo '- DONE -'

ecr-push-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Push Container Image Nifi Registry (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-push.sh $(ARGS) $(CI_PATH) ubuntu
	@sh ./ecr-push.sh $(ARGS) $(CI_PATH) latest
	@sh ./ecr-push.sh $(ARGS) $(CI_PATH) ${NIFI_REGISTRY_VERSION}
	@echo '- DONE -'

# ================== #
#   PULL CONTAINER   #
# ================== #
.PHONY: pull-nifi pull-nifi-registry

# ./ecr-pull.sh [AWS_ACCOUNT] [ECR_PATH] [alpine|ubuntu|codebuild|version|latest|tags|custom-tags]
ecr-pull-nifi:
	@echo "=============================================================="
	@echo " Task      : Pull Container Image Nifi (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-pull.sh $(ARGS) $(CI_PATH) ubuntu
	@sh ./ecr-pull.sh $(ARGS) $(CI_PATH) latest
	@sh ./ecr-pull.sh $(ARGS) $(CI_PATH) ${NIFI_VERSION}
	@echo '- DONE -'

ecr-pull-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Pull Container Image Nifi Registry (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-pull.sh $(ARGS) $(CI_PATH) ubuntu
	@sh ./ecr-pull.sh $(ARGS) $(CI_PATH) latest
	@sh ./ecr-pull.sh $(ARGS) $(CI_PATH) ${NIFI_REGISTRY_VERSION}
	@echo '- DONE -'

# =========================== #
#   PROVISIONING INFRA CORE   #
# =========================== #
.PHONY: tf-core-init tf-core-create-workspace tf-core-select-workspace tf-core-plan tf-core-apply
tf-core-init:
	@echo "=============================================================="
	@echo " Task      : Terraform Init "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@cd $(TF_CORE) && terraform init $(ARGS)
	@echo '- DONE -'
tf-core-create-workspace:
	@echo "=============================================================="
	@echo " Task      : Terraform Create Workspace "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@cd $(TF_CORE) && terraform workspace new $(ARGS)
	@echo '- DONE -'
tf-core-select-workspace:
	@echo "=============================================================="
	@echo " Task      : Terraform Select Workspace "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@cd $(TF_CORE) && terraform workspace select $(ARGS)
	@echo '- DONE -'
tf-core-plan:
	@echo "=============================================================="
	@echo " Task      : Terraform Plan Provisioning "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@cd $(TF_CORE) && terraform plan $(ARGS)
	@echo '- DONE -'
tf-core-apply:
	@echo "=============================================================="
	@echo " Task      : Provisioning Terraform "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@cd $(TF_CORE) && terraform apply -auto-approve
	@echo '- DONE -'

# ================================ #
#   PROVISIONING RESOURCES INFRA   #
# ================================ #
.PHONY: tf-infra-init tf-infra-create-workspace tf-infra-select-workspace tf-infra-plan tf-infra-apply tf-infra-resource
tf-infra-init:
	@echo "=============================================================="
	@echo " Task      : Terraform Init "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@cd $(TF_RESOURCES)/$(INFRA_RESOURCES) && terraform init $(ARGS)
	@echo '- DONE -'
tf-infra-create-workspace:
	@echo "=============================================================="
	@echo " Task      : Terraform Create Workspace "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@cd $(TF_RESOURCES)/$(INFRA_RESOURCES) && terraform workspace new $(ARGS)
	@echo '- DONE -'
tf-infra-select-workspace:
	@echo "=============================================================="
	@echo " Task      : Terraform Select Workspace "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@cd $(TF_RESOURCES)/$(INFRA_RESOURCES) && terraform workspace select $(ARGS)
	@echo '- DONE -'
tf-infra-plan:
	@echo "=============================================================="
	@echo " Task      : Terraform Plan Provisioning "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@cd $(TF_RESOURCES)/$(INFRA_RESOURCES) && terraform plan $(ARGS)
	@echo '- DONE -'
tf-infra-apply:
	@echo "=============================================================="
	@echo " Task      : Provisioning Terraform "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@cd $(TF_RESOURCES)/$(INFRA_RESOURCES) && terraform apply -auto-approve $(ARGS)
	@echo '- DONE -'

# =============================== #
#   PROVISIONING SPESIFIC INFRA   #
# =============================== #
.PHONY: tf-infra-resource
tf-infra-resource:
	@echo "=============================================================="
	@echo " Task      : Terraform Command $(ARGS)"
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@cd $(TF_RESOURCES)/$(INFRA_RESOURCES) && terraform $(ARGS)
	@echo '- DONE -'
