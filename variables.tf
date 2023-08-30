# Content of inventory.ini
variable "inventory_content" {
  type = string
  default = "ansible_ssh_private_key_file=/Users/shark_attack/Downloads/daniils-key.pem ansible_user=ubuntu"
}

# Location of inventory.ini
variable "inventory_filename" {
  type = string
  default = "/Users/shark_attack/Desktop/cloud_bootcamp_final_task/inventory.ini"
}