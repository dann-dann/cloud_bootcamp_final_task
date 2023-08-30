# cloud_bootcamp_final_task

# Terraform
Before starting, ensure that you have installed:<br/>
AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html<br/>
Terraform: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli<br/>

## Clone the repository
`git clone https://github.com/dann-dann/cloud_bootcamp_final_task.git`<br/>
`cd cloud_bootcamp_final_task/terraform`<br/><br/>

## Set Up AWS Credentials
`aws configure`<br/><br/>

## Review Configuration
Review all **.tf** files (in _/terraform_ directory) and make sure they match your desired infrastucture.<br/><br/>
**NOTE:** You may consider changing **inventory_content** and **inventory_filename** values (in variables.tf). <br/>They are responsible for creating **inventory.ini** and populating it with data<br/><br/>

## Initialize Terraform
`terraform init`<br/><br/>

## Plan Changes
Generate an execution plan to see what Terraform will do before making any changes to your infrastructure:<br/>
`terraform plan`<br/><br/>

## Apply Changes
`terraform apply`<br/>
If done correctly, Terraform will create **inventory.ini** file in **cloud_bootcamp_final_task** directory, which will contain connection info for Ansible.<br/><br/>

## Accessing EC2 Instance
Once the deployment is complete, you will see information about the created EC2 instance. You can SSH into the instance using the key pair specified in **main.tf**.<br/><br/><br/>

# Ansible
Ensure that you have installed:<br/>
Ansible: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html<br/><br/>

## Review Ansible Playbook
Review **install_nginx.yml** Ansible playbook file to ensure it matches your desired Nginx installation and configuration.<br/><br/>

## Run Ansible Playbook
This command will configure Nginx on your EC2 instance.<br/>
`ansible-playbook --inventory-file=<location_to_the_directory>/cloud_bootcamp_final_task/inventory.ini install_nginx.yml`<br/><br/>
**NOTE:** Replace **<location_to_the_directory>/cloud_bootcamp_final_task/inventory.ini** with the path to your inventory file if it's in a different location<br/>
**NOTE 2:** You may consider `chmod 600 <path_to_your_private_key/key.pem`
