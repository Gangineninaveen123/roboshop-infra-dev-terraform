#!/bin/bash
#component=mongodb
#component=$1
#component=${component}
# dnf install ansible -y

# #-U <URL>: Specifies the URL of the Git repository containing the playbooks.

# ansible-pull -U https://github.com/Gangineninaveen123/ansible-roboshop-roles.git -e component=${component} main.yaml



#component=mongodb
component=$1
dnf install ansible -y

#-U <URL>: Specifies the URL of the Git repository containing the playbooks.

ansible-pull -U https://github.com/Gangineninaveen123/ansible-roboshop-roles.git -e component=$1 main.yaml
