#!/usr/bin/env sh

IP_PARSER='get_ips.py'
IP_FILE='ips.json'
TERRAFORM=$(which terraform)
#TFVARS='terraform.tfvars'
SCANNER_IPS=$(./$IP_PARSER $IP_FILE scan)
SC_IP=$(./$IP_PARSER $IP_FILE sc)


check_dependencies () {
#  if [ ! -f $IP_FILE ]; then
#  echo "Required file is missing: $IP_FILE"
#  exit 1
#fi
  if [ ! -f $IP_PARSER ]; then
  echo "Required file is missing: $IP_PARSER"
  exit 1
fi
  if [ ! -n "${TERRAFORM}" ]; then
  echo "Required dependency is missing: terraform"
  exit 1
fi
}

kickoff_terraform () {
  $TERRAFORM init && $TERRAFORM apply -auto-approve
}

gather_terraform_output () {
  $TERRAFORM output -json > $IP_FILE
}




check_dependencies
kickoff_terraform
gather_terraform_output