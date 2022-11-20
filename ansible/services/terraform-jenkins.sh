#!/bin/sh

### Script Jenkins Pipeline
# Using Parameters:
# 1. Terraform Environment (lab, prod, staging)
# 2. Terraform State (init, validate, plan, apply, destroy)

### How to Use:
# ./terraform-jenkins.sh staging init
# ./terraform-jenkins.sh staging validate
# ./terraform-jenkins.sh staging plan
# ./terraform-jenkins.sh staging apply
# ./terraform-jenkins.sh staging destroy

set -e

TITLE="TERRAFORM EXECUTION SCRIPT"   # script name
VER="2.2"                            # script version

CICD_TERRAFORM_ENVIRONMENT=$1
CICD_TERRAFORM_STATE=$2
CICD_TERRAFORM_ARGS=$3

COL_RED="\033[22;31m"
COL_GREEN="\033[22;32m"
COL_BLUE="\033[22;34m"
COL_END="\033[0m"

get_time() {
  DATE=$(date '+%Y-%m-%d %H:%M:%S')
}

print_line0() {
  echo "$COL_GREEN=====================================================================================$COL_END"
}

print_line1() {
  echo "$COL_GREEN-------------------------------------------------------------------------------------$COL_END"
}

print_line2() {
  echo "-------------------------------------------------------------------------------------"
}

logo() {
  clear
  print_line0
  echo "$COL_RED'########:'########:'########:::'#######:::'######::::'#####:::'########:::'#######:: $COL_END"
  echo "$COL_RED..... ##:: ##.....:: ##.... ##:'##.... ##:'##... ##::'##.. ##:: ##.... ##:'##.... ##: $COL_END"
  echo "$COL_RED:::: ##::: ##::::::: ##:::: ##: ##:::: ##: ##:::..::'##:::: ##: ##:::: ##:..::::: ##: $COL_END"
  echo "$COL_RED::: ##:::: ######::: ########:: ##:::: ##: ##::::::: ##:::: ##: ##:::: ##::'#######:: $COL_END"
  echo "$COL_RED:: ##::::: ##...:::: ##.. ##::: ##:::: ##: ##::::::: ##:::: ##: ##:::: ##::...... ##: $COL_END"
  echo "$COL_RED: ##:::::: ##::::::: ##::. ##:: ##:::: ##: ##::: ##:. ##:: ##:: ##:::: ##:'##:::: ##: $COL_END"
  echo "$COL_RED ########: ########: ##:::. ##:. #######::. ######:::. #####::: ########::. #######:: $COL_END"
  echo "$COL_RED........::........::..:::::..:::.......::::......:::::.....::::........::::.......::: $COL_END"
  print_line1
  echo "$COL_BLUE# $TITLE :: ver-$VER $COL_END"
  echo "$COL_GREEN# TERRAFORM ENVIRONMENT :: $CICD_TERRAFORM_ENVIRONMENT $COL_END"
  echo "$COL_GREEN# TERRAFORM STATE       :: $CICD_TERRAFORM_STATE $COL_END"
}

header() {
  logo
  print_line0
  get_time
  echo "$COL_RED# BEGIN PROCESS..... (Please Wait)  $COL_END"
  echo "$COL_RED# Start at: $DATE  $COL_END"
}

footer() {
  echo ""
  print_line0
  get_time
  echo "$COL_RED# Finish at: $DATE  $COL_END"
  echo "$COL_RED# END PROCESS.....  $COL_END\n"
}

execute_terraform() {
  msg_terraform
  if [ "$CICD_TERRAFORM_STATE" = "apply" ]
  then
    terraform $CICD_TERRAFORM_STATE -auto-approve
  else
    terraform $CICD_TERRAFORM_STATE
  fi
  echo "- DONE -"
}

msg_terraform() {
  echo ""
  print_line2
  get_time
  echo "$COL_BLUE[ $DATE ] ##### Terraform State : $CICD_TERRAFORM_STATE "
  echo "$COL_GREEN[ $DATE ]       terraform $CICD_TERRAFORM_STATE $CICD_TERRAFORM_ARGS $COL_END"
  get_time
  print_line2
}

main() {
  header
  execute_terraform $CICD_TERRAFORM_ENVIRONMENT $CICD_TERRAFORM_STATE $CICD_TERRAFORM_ARGS
  footer
}

### START HERE ###
main $1 $2 $3
