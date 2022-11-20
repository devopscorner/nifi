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
dockerhub-build-nifi:
	@echo "=============================================================="
	@echo " Task      : Create Container Image Nifi (DockerHub) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./dockerhub-build.sh nifi Dockerfile-Nifi ${NIFI_VERSION} $(CI_PATH)
	@echo '- DONE -'

dockerhub-build-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Create Container Image Nifi Registry (DockerHub) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./dockerhub-build.sh nifi-registry Dockerfile-Nifi-Registry ${NIFI_REGISTRY_VERSION} $(CI_PATH)
	@echo '- DONE -'

ecr-build-nifi:
	@echo "=============================================================="
	@echo " Task      : Create Container Image Nifi (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-build.sh $(ARGS) nifi Dockerfile-Nifi ${NIFI_VERSION} $(CI_PATH)
	@echo '- DONE -'

ecr-build-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Create Container Image Nifi Registry (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-build.sh $(ARGS) nifi-registry Dockerfile-Nifi-Registry ${NIFI_REGISTRY_VERSION} $(CI_PATH)
	@echo '- DONE -'

# ================== #
#   TAGS CONTAINER   #
# ================== #
.PHONY: dockerhub-tag-nifi dockerhub-tag-nifi-registry ecr-tag-nifi ecr-tag-nifi-registry
dockerhub-tag-nifi:
	@echo "=============================================================="
	@echo " Task      : Set Tags Image Nifi (DockerHub) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./dockerhub-tag.sh nifi ${NIFI_VERSION} $(CI_PATH)
	@echo '- DONE -'

dockerhub-tag-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Set Tags Image Nifi Registry (DockerHub) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./dockerhub-tag.sh nifi-registry ${NIFI_REGISTRY_VERSION} $(CI_PATH)
	@echo '- DONE -'

ecr-tag-nifi:
	@echo "=============================================================="
	@echo " Task      : Set Tags Image Nifi (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-tag.sh $(ARGS) nifi ${NIFI_VERSION} $(CI_PATH)
	@echo '- DONE -'

ecr-tag-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Set Tags Image Nifi Registry (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-tag.sh $(ARGS) nifi-registry ${NIFI_REGISTRY_VERSION} $(CI_PATH)
	@echo '- DONE -'

# ================== #
#   PUSH CONTAINER   #
# ================== #
.PHONY: dockerhub-push-nifi dockerhub-push-nifi-registry ecr-push-nifi ecr-push-nifi-registry
dockerhub-push-nifi:
	@echo "=============================================================="
	@echo " Task      : Push Container Image Nifi (DockerHub) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./dockerhub-push.sh nifi $(CI_PATH)
	@echo '- DONE -'

dockerhub-push-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Push Container Image Nifi Registry (DockerHub) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-push.sh nifi-registry $(CI_PATH)
	@echo '- DONE -'

ecr-push-nifi:
	@echo "=============================================================="
	@echo " Task      : Push Container Image Nifi (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-push.sh $(ARGS) nifi $(CI_PATH)
	@echo '- DONE -'

ecr-push-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Push Container Image Nifi Registry (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-push.sh $(ARGS) nifi-registry $(CI_PATH)
	@echo '- DONE -'

# ================== #
#   PULL CONTAINER   #
# ================== #
.PHONY: pull-nifi pull-nifi-registry
ecr-pull-nifi:
	@echo "=============================================================="
	@echo " Task      : Pull Container Image Nifi (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-pull.sh $(ARGS) nifi $(CI_PATH)
	@echo '- DONE -'

ecr-pull-nifi-registry:
	@echo "=============================================================="
	@echo " Task      : Pull Container Image Nifi Registry (ECR) "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@sh ./ecr-pull.sh $(ARGS) nifi-registry $(CI_PATH)
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
