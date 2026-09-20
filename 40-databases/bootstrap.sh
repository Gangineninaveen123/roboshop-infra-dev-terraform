#!/bin/bash
#component=mongodb
component=$1
dnf install ansible -y

#-U <URL>: Specifies the URL of the Git repository containing the playbooks.

ansible-pull -U https://github.com/Gangineninaveen123/ansible-roboshop-roles-tf.git -e component=$1 -e env=$2 main.yaml #$2, means second argument i have given as dev, check in provisioner "remote-exec in main.tf
