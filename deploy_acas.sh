#!/usr/bin/env sh

IP_PARSER='get_ips.py'
IP_FILE='ips.json'
TERRAFORM=$(which terraform)
PYTHON=$(which python3)
ANSIBLE_PLAYBOOK=$(which ansible-playbook)
PYTHON_VENV_PATH="$HOME/.venv"
#TFVARS='terraform.tfvars'
SCANNER_IPS=$(./$IP_PARSER $IP_FILE scan)
SC_IP=$(./$IP_PARSER $IP_FILE sc)


check_dependencies () {
  if [ ! -f $IP_PARSER ]; then
  echo "Required file is missing: $IP_PARSER"
  exit 1
fi
  if [ ! -n "${TERRAFORM}" ]; then
  echo "Required dependency is missing: terraform"
  exit 1
fi
  if [ ! -n "${PYTHON}" ]; then
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

create_venv_if_not_exist () {
  if [ ! -d $PYTHON_VENV_PATH ]; then
  $PYTHON -m venv "$HOME/.venv"
  else
    echo "venv check passed: $PYTHON_VENV_PATH"
  fi
}

activate_venv () {
  if [ -d $PYTHON_VENV_PATH ]; then
  activate "$HOME/.venv/bin/activate"
  fi
}

check_if_ansible_is_installed () {
  check=$(pip list |egrep ansible|wc -l)
  if [ ! $check -gt 0 ]; then
  pip install ansible
  else
  echo "ansible check passed: $check"
  fi
}
## run area
check_dependencies
create_venv_if_not_exist
activate_venv
check_if_ansible_is_installed
kickoff_terraform
gather_terraform_output