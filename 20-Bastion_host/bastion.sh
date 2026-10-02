#!/bin/bash

# i am installing terraform in bastion host, as below, and incresung the the size of /home path or deirectory, while faced size issues, so, now it is increeased., to run terraform commands, while connecting and exucuting the components.
yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform

growpart /dev/nvme0n1 4
lvextend -L +20G /dev/RootVG/rootVol
lvextend -L +10G /dev/RootVG/homeVol

xfs_growfs /
xfs_growfs /home