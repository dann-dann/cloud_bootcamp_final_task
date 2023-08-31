# Project Introduction
This project demonstrates the deployment of a web application to an AWS EC2 instance using tools like Terraform and configuration management with Ansible.<br/>
The goal is to automate the process of provisioning infrastructure, deploying a web server (Nginx) and managing the application's lifecycle.

## Key Components
- Terraform: Infrastructure is defined as code using Terraform, making it easy to create and manage AWS resources such as EC2 instances and security groups.
- Ansible: Configuration management with Ansible ensures that the EC2 instances are correctly provisioned and configured with Nginx, creating a reliable and repeatable deployment process.
- GitHub Actions: Automation of the deployment pipeline is achieved with GitHub Actions, which automatically deploys code changes to the EC2 instance whenever a commit is made to the main branch.


# Prerequisites
Before starting, ensure that you have installed:<br/>
- AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html<br/>
- Terraform: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli<br/>
<sup>aws provider version ~>5.0</sup>
- Ansible: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html<br/><br/>

# Guide
Fork and then clone the repository
```
git clone https://github.com/dann-dann/cloud_bootcamp_final_task.git
```
Navigate to the working directory
```
cd cloud_bootcamp_final_task/terraform
```

# Terraform Part

## Set Up AWS Credentials
```
aws configure
```

## Review Configuration
Review all **.tf** files (in _/terraform_ directory) and make sure they match your desired infrastucture.<br/><br/>
**NOTE:** You may consider changing **inventory_content** and **inventory_filename** values (in variables.tf). <br/>They are responsible for creating **inventory.ini** and populating it with data<br/><br/>

## Initialize Terraform
```
terraform init
```

## Plan Changes
Generate an execution plan to see what Terraform will do before making any changes to your infrastructure:<br/>
```
terraform plan
```

## Apply Changes
```
terraform apply
```
If done correctly, Terraform will create **inventory.ini** file in **cloud_bootcamp_final_task** directory, which will contain connection info for Ansible.<br/><br/>

## Accessing EC2 Instance
Once the deployment is complete, you will see information about the created EC2 instance. You can SSH into the instance using the key pair specified in **main.tf**.<br/><br/><br/>


# Ansible Part

## Review Ansible Playbook
Review **install_nginx.yml** Ansible playbook file to ensure it matches your desired Nginx installation and configuration.<br/><br/>

## Run Ansible Playbook
This command will configure Nginx on your EC2 instance.<br/>
```
ansible-playbook --inventory-file=<location_to_the_directory>/cloud_bootcamp_final_task/inventory.ini install_nginx.yml
```
>**NOTE:** Replace **<location_to_the_directory>/cloud_bootcamp_final_task/inventory.ini** with the path to your inventory file if it's in a different location<br/><br/>
>**NOTE 2:** You may consider `chmod 600 <path_to_your_private_key>/key.pem`
<br/>

# Github Actions Part
GitHub Actions provides an automated workflow that allows you to deploy your code or perform other tasks whenever changes are pushed to your repository.<br/>
In this project, the GitHub Actions workflow  is set to automatically deploy the index.html file to your AWS EC2 instance whenever changes are pushed to the main branch.

The GitHub Actions workflow is defined in the **.github/workflows/upload_to_ec2.yml** file.<br/>
It defines a single job named deploy that runs on an Ubuntu runner. This job contains the steps to deploy the index.html file.<br/>
The deployment step uses the easingthemes/ssh-deploy GitHub Action, which simplifies the process of copying files to a remote server over SSH.<br/><br/>

## Adding PRIVATE_KEY and REMOTE_HOST secrets
### PRIVATE_KEY
Copy the entire contents of your private key, including the -----BEGIN RSA PRIVATE KEY----- and -----END RSA PRIVATE KEY----- lines.<br/><br/>
In your GitHub repository, navigate to the "Settings" tab.<br/>
In the left sidebar, click on "Secrets and variables" -> "Actions"<br/><br/>
![CleanShot 2023-08-31 at 01 51 39](https://github.com/dann-dann/cloud_bootcamp_final_task/assets/28223542/494997d1-e7bf-41b6-a9eb-b4b5b4ad6b81)


Click on the "New repository secret" button.<br/>
For the "Name," enter PRIVATE_KEY.<br/>
In the "Secret" field, paste the contents of your private key.<br/>
Click the "Add secret" button to save it.<br/><br/>

### REMOTE_HOST
Determine the public IP address of your AWS EC2 instance.
Perform same steps as before, but this time<br/>
For the "Name," enter REMOTE_HOST.<br/>
In the "Secret" field, paste the public IP address of your EC2 instance.<br/>
Click the "Add secret" button to save it.<br/><br/>

These secrets (**PRIVATE_KEY** and **REMOTE_HOST**) will be used by the GitHub Actions workflow to securely authenticate and connect to your EC2 instance over SSH for deployment.<br/><br/><br/><br/>


# Cleanup
To remove the AWS resources created by Terraform, you can use<br/>
```
terraform destroy
```
Terraform will generate an execution plan showing the resources it plans to destroy.<br/><br/>

## Confirm destruction
When prompted, type `yes` to confirm the destruction of the resources.<br/>
>Do you really want to destroy all resources?
  >Terraform will destroy all your managed infrastructure, as shown above.
  >There is no undo. Only 'yes' will be accepted to confirm.
