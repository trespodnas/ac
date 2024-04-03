# Acas deploymemt scripts

#### Requirements:
* Python3
* Azure cli, [az-cli download](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
* Terraform cli, [terraform download](https://www.terraform.io/downloads)
* Git cli, [Download git for MacOS](https://git-scm.com/download/mac), [Download git for Windoze](https://gitforwindows.org/)
* Ansible
* terraform.tfvars file
* Nessus / ACAS rpms from: https://patches.csd.disa.mil/ , place them in the tenable_files_repo directory (ensure there are no spaces in the naming)

#### What does it do?:
Creates 3 azure vm instances (per tenable specs). <br>
Updates instances<br>
Installs security center on one host and nessus (scanner) on the other two<br>
Applies a high level STIG for RHEL 8 to instances, currently V1 R13<br>
Uses acas/tenable installable(s) from : https://patches.csd.disa.mil/
# ---
* <mark>*note</mark>: ansible will be installed automatically per the "deploy_acas.sh" script. Some deployment environments 
may have these tools  already installed ex: cloud shell <br>
* ansible will not work as a control node in a vanilla windoze environment, it will require WSL to be installed/configured
<br>


#### Getting started:
Clone this repo./copy to your environment<br>
Copy the "terraform.tfvars.template_file" & create a new file named "terraform.tfvars", keep it in the root of the repo, 
where there template was located<br>
Open the tfvars file with your editor and fill in
resource_group_name/location, existing_vnet_name/location & existing_subnet_name<br>

#### Kick it off
After the above steps are completed run the deploy_acas.sh script

#### Post install items:
Configure security center, attach license, attach scanners to acas/security center <br>
* <mark>*note</mark>: the host names are attached to the licenses, more than likely will you have to rename the hostname within
the security center instance (hostname-ctl set-hostname myNewHostnameThatConformsToLicenseName) to match the hostname attached
to the license
<br>

##### Updating/Customization 
* When new RPMs are released for acas/nessus , the names of those files can be updated in the "config_mgmt/group_vars/all.yml"
file, ensure that the downloaded RPMs do not contain any spaces as there are naming inconsistencies with files downloaded from that site
* Server names/size changes: change in "locals.tf" file