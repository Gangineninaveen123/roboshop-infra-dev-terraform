module "frontend-sg" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.frontend_sg_name
    sg_discription = var.frontend_sg_discription

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

# for bastion instance creating security group, for connecting securely to other instances...
module "bastion" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.bastion_sg_name
    sg_discription = var.bastion_sg_discription

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}


#search google in -> aws security group rule terraform [for ssh login -> port 22]

# bastion accepting connections from my laptop
#need to login sequrely, so we are using or opening only port 22[ssh]
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22 #need to login sequrely, so we are using or opening only port 22[ssh]
  to_port           = 22 #need to login sequrely, so we are using or opening only port 22[ssh]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] #for present, i am giving allow all puclic
  security_group_id = module.bastion.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha.
}


# for backend ALB[application Load Balancer] creating security group, for connecting securely to other instances...
module "backend_alb" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "backend_alb"
    sg_discription = "backend_alb_sg_discription"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}


#search google in -> aws security group rule terraform
# backend ALB accepting connections from my bastion host on port no 80
resource "aws_security_group_rule" "backend_alb_acceptingConnectionFrom_bastion" {
  type              = "ingress"
  from_port         = 80 
  to_port           = 80 
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.backend_alb.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}


#creating mongodb security group
module "mongodb" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "mongodb-sg-12sept"
    sg_discription = "mongodb_sg_discription_12sept"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

# mongodb open ports :- 22, 27017  -> these all ports i need to enable from mongodb.

# mongodb accepting connections from my openvpn host on port no 22 and 27017
resource "aws_security_group_rule" "mongodb_acceptingConnectionFrom_openvpn_ssh" {
  count = length(var.mongodb_ports_vpn)
  type              = "ingress"
  from_port         = var.mongodb_ports_vpn[count.index]
  to_port           = var.mongodb_ports_vpn[count.index] 
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.mongodb.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

/* # mongodb accepting connections from my openvpn host on port no 27017
resource "aws_security_group_rule" "mongodb_acceptingConnectionFrom_openvpn_ssh" {
  type              = "ingress"
  from_port         = 27017 
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.mongodb.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}
 */

#creating mysql security group
module "mysql" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "mysql-sg-12sept"
    sg_discription = "mysql_sg_discription_12sept"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

# mysql open ports :- 22, 3306  -> these all ports i need to enable from mongodb.

# mongodb accepting connections from my openvpn host on port no 22 and 27017
resource "aws_security_group_rule" "mysql_acceptingConnectionFrom_openvpn_ssh" {
  count = length(var.mysql_ports_vpn)
  type              = "ingress"
  from_port         = var.mysql_ports_vpn[count.index]
  to_port           = var.mysql_ports_vpn[count.index] 
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.mysql.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

#creating redis security group
module "redis" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "redis-sg-12sept"
    sg_discription = "redis_sg_discription_12sept"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

# redis open ports :- 22, 6379  -> these all ports i need to enable from mongodb.

# redis accepting connections from my openvpn host on port no 22 and 27017
resource "aws_security_group_rule" "redis_acceptingConnectionFrom_openvpn_ssh" {
  count = length(var.redis_ports_vpn)
  type              = "ingress"
  from_port         = var.redis_ports_vpn[count.index]
  to_port           = var.redis_ports_vpn[count.index] 
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.redis.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

#creating rabbitmq security group
module "rabbitmq" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "rabbitmq-sg-12sept"
    sg_discription = "rabbitmq_sg_discription_12sept"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

# rabbitmq open ports :- 22, 5672  -> these all ports i need to enable from mongodb.

# rabbitmq accepting connections from my openvpn host on port no 22 and 27017
resource "aws_security_group_rule" "rabbitmq_acceptingConnectionFrom_openvpn_ssh" {
  count = length(var.rabbitmq_ports_vpn)
  type              = "ingress"
  from_port         = var.rabbitmq_ports_vpn[count.index]
  to_port           = var.rabbitmq_ports_vpn[count.index] 
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.rabbitmq.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

#creating catalogue security group
module "catalogue" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "catalogue-sg-12sept"
    sg_discription = "catalogue_sg_discription_12sept"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}
#catalogue accepting connection from openvpn, bastion, alb, and mongodb allowing coonection for catlogue below, check indetail.

resource "aws_security_group_rule" "catalogue_acceptingConnectionFrom_backend_alb" {
  
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.catalogue.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

resource "aws_security_group_rule" "catalogue_acceptingConnectionFrom_openvpn_ssh" {
  
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.catalogue.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

resource "aws_security_group_rule" "catalogue_acceptingConnectionFrom_openvpn_http" {
  
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.catalogue.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

resource "aws_security_group_rule" "catalogue_acceptingConnectionFrom_bastion" {
  
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.catalogue.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

resource "aws_security_group_rule" "mongodb_acceptingConnectionFrom_catalogue" {
  
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.catalogue.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.mongodb.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}
# for openvpn creating security group, for connecting securely to other instances...
module "openvpn" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "openvpn-sg-12sept"
    sg_discription = "openvpn_sg_discription_12sept"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

# vpn ports :- 22, 443, 1194, 943  -> these all ports i need to enable from public.

# backend ALB accepting connections from my openvpn host on port no 80
resource "aws_security_group_rule" "backend_alb_acceptingConnectionFrom_openvpn" {
  type              = "ingress"
  from_port         = 80 
  to_port           = 80 
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.backend_alb.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

#search google in -> aws security group rule terraform
#SSH to OpenVPN EC2
resource "aws_security_group_rule" "openvpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22 
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.openvpn.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

#Optional VPN over HTTPS
resource "aws_security_group_rule" "openvpn_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.openvpn.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}
# Port 1194 is the default OpenVPN port. We create an ingress rule on port 1194 so VPN clients on the Internet can connect to the OpenVPN server in public subnet. The rule 0.0.0.0/0 allows connections from any public IP. Once connected, users can securely access private resources inside the VPC through the VPN tunnel.
#VPN Tunnel Connections
resource "aws_security_group_rule" "openvpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.openvpn.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

#OpenVPN Web UI (Admin/User Portal)
#Port 943 is used by OpenVPN Access Server's web interface. It provides the admin dashboard and user portal for downloading VPN profiles and managing VPN users. Security group ingress on TCP 943 allows administrators and users to access the OpenVPN web console through a browser.
resource "aws_security_group_rule" "openvpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.openvpn.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}
