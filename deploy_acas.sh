#!/usr/bin/env sh

IP_PARSER='get_ips.py'
IP_FILE='ips.json'
TERRAFORM=$(which terraform)
TFVARS='terraform.tfvars'


check_dependencies () {
  if [ ! -f $IP_FILE ]; then
  echo "Required file is missing: $IP_FILE"
  exit 1
fi
  if [ ! -f $IP_PARSER ]; then
  echo "Required file is missing: $IP_PARSER"
  exit 1
fi
  if [ ! -n "${TERRAFORM}" ]; then
  echo "Required dependency is missing: terraform"
  exit 1
fi
}

kickoff_teraform () {
  $TERRAFORM init . && $TERRAFORM -f
}


check_dependencies
