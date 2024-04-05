#!/usr/bin/env sh

IP_PARSER='get_ips.py'
IP_FILE='ips.json'
TERRAFORM=$(which terraform)
PYTHON=$(which python3)
PYTHON_VENV_PATH="$HOME/.venv"
DEFAULT_VM_ACAS_UN='acas'



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
  $TERRAFORM output -json > $IP_FILE && sleep 15
  pid=$!
  wait $pid
}

create_venv_if_not_exist () {
  if [ ! -d "$PYTHON_VENV_PATH" ]; then
  $PYTHON -m venv "$HOME/.venv"
  else
    echo "venv check passed: $PYTHON_VENV_PATH"
  fi
}

activate_venv () {
  if [ -d "$PYTHON_VENV_PATH" ]; then
  . "$HOME/.venv/bin/activate"
  fi
}

upgrade_venv_pip () {
  check=$(pip list |egrep ansible|wc -l)
  if [ ! "$check" -gt 0 ]; then
  pip install --upgrade pip
  fi
}

check_if_ansible_is_installed () {
  check=$(pip list |egrep ansible|wc -l)
  if [ ! "$check" -gt 0 ]; then
  pip install ansible
  else
  echo "ansible check passed: $check"
  fi
}

kick_off_general_config_and_baseline_stig () {
  ALL_IPS=$(./$IP_PARSER $IP_FILE ip)
  SCP_IF_SSH=true ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --user $DEFAULT_VM_ACAS_UN --become-user root -i "$ALL_IPS" config_mgmt/basic_config.yml
  pid=$!
  wait $pid
}

kick_off_securitycenter_install () {
  SC_IP=$(./$IP_PARSER $IP_FILE sc)
  SCP_IF_SSH=true ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --user $DEFAULT_VM_ACAS_UN --become-user root -i "$SC_IP" config_mgmt/sc_config.yml
  pid=$!
  wait $pid
}

kick_off_nessus_install () {
  SCANNER_IPS=$(./$IP_PARSER $IP_FILE scan)
  SCP_IF_SSH=true ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --user $DEFAULT_VM_ACAS_UN --become-user root -i "$SCANNER_IPS" config_mgmt/scanner_config.yml
  pid=$!
  wait $pid
}

## run area
check_dependencies
create_venv_if_not_exist
activate_venv
upgrade_venv_pip
check_if_ansible_is_installed
kickoff_terraform
gather_terraform_output
kick_off_general_config_and_baseline_stig
kick_off_securitycenter_install
kick_off_nessus_install