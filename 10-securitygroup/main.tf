# Creating all security groups, as per sg.yaml for better understanding and in flow....

#creating mongodb security group
module "mongodb" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "mongodb-sg"
    sg_discription = "for mongodb"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

#creating redis security group
module "redis" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "redis-sg"
    sg_discription = "for redis_sg"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

#creating mysql security group
module "mysql" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "mysql-sg"
    sg_discription = "for mysql_sg"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

#creating rabbitmq security group
module "rabbitmq" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "rabbitmq-sg"
    sg_discription = "for rabbitmq_sg"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

#creating catalogue security group
module "catalogue" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "catalogue-sg"
    sg_discription = "for catalogue_sg"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

#creating user security group
module "user" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "user-sg"
    sg_discription = "for user_sg"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

#creating cart security group
module "cart" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "cart-sg"
    sg_discription = "cart_sg"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

#creating shipping security group
module "shipping" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "shipping-sg"
    sg_discription = "shipping_sg"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

#creating payment security group
module "payment" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "payment-sg"
    sg_discription = "for payment_sg"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

# for backend ALB[application Load Balancer] creating security group, for connecting securely to other instances...
module "backend_alb" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "backend_alb"
    sg_discription = "for backend_alb"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

#frontend security group
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

# frontend application load balancer
module "frontend_alb" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "frontend_alb"
    sg_discription = "for frontend_alb"

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

# for openvpn creating security group, for connecting securely to other instances...
module "openvpn" {
    #source = "../../Module-terraform-aws-securitygroup"  # reffered from local
    # now below reffering from git
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "openvpn-sg"
    sg_discription = "for openvpn_sg"

    # here i ll get vpc_id,[locals all detals are there] through data sources, , where that data source is taking the vpc_id from the SSM Parameter from aws.
    vpc_id = local.vpc_id
}

# ***** SECURITY GROUP RULES *************
# mongodb accepting connections from my openvpn host on port no 22 and 27017
resource "aws_security_group_rule" "mongodb_acceptingConnectionFrom_openvpn" {
  count = length(var.mongodb_ports_vpn)
  type              = "ingress"
  from_port         = var.mongodb_ports_vpn[count.index]
  to_port           = var.mongodb_ports_vpn[count.index] 
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.mongodb.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

resource "aws_security_group_rule" "mongodb_bastion" {
  count = length(var.mongodb_ports_vpn)
  type              = "ingress"
  from_port         = var.mongodb_ports_vpn[count.index]
  to_port           = var.mongodb_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_acceptingConnectionFrom_catalogue" {
  
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.catalogue.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.mongodb.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

resource "aws_security_group_rule" "mongodb_acceptingConnectionFrom_user" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id = module.mongodb.sg_id
}

#*************** REDIS SECURITY GROUP RULES ***********************

# redis accepting connections from my openvpn host on port no 22 and 27017
resource "aws_security_group_rule" "redis_acceptingConnectionFrom_openvpn" {
  count = length(var.redis_ports_vpn)
  type              = "ingress"
  from_port         = var.redis_ports_vpn[count.index]
  to_port           = var.redis_ports_vpn[count.index] 
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.redis.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

resource "aws_security_group_rule" "redis_acceptingConnectionFrom_bastion" {
  count = length(var.redis_ports_vpn)
  type              = "ingress"
  from_port         = var.redis_ports_vpn[count.index]
  to_port           = var.redis_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_acceptingConnectionFrom_user" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_acceptingConnectionFrom_cart" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id = module.redis.sg_id
}

#**************MYSQL SECURITY GROUP RULES ***************

resource "aws_security_group_rule" "mysql_acceptingConnectionFrom_openvpn" {
  count = length(var.mysql_ports_vpn)
  type              = "ingress"
  from_port         = var.mysql_ports_vpn[count.index]
  to_port           = var.mysql_ports_vpn[count.index] 
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.mysql.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

resource "aws_security_group_rule" "mysql_acceptingConnectionFrom_bastion" {
  count = length(var.mysql_ports_vpn)
  type              = "ingress"
  from_port         = var.mysql_ports_vpn[count.index]
  to_port           = var.mysql_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.mysql.sg_id
}

resource "aws_security_group_rule" "mysql_acceptingConnectionFrom_shipping" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id = module.mysql.sg_id
}

#************** RabbitMQ SECURITY GROUP RULES ******************
# rabbitmq accepting connections from my openvpn host on port no 22 and 5672
resource "aws_security_group_rule" "rabbitmq_acceptingConnectionFrom_openvpn" {
  count = length(var.rabbitmq_ports_vpn)
  type              = "ingress"
  from_port         = var.rabbitmq_ports_vpn[count.index]
  to_port           = var.rabbitmq_ports_vpn[count.index] 
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.rabbitmq.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

resource "aws_security_group_rule" "rabbitmq_acceptingConnectionFrom_bastion" {
  count = length(var.rabbitmq_ports_vpn)
  type              = "ingress"
  from_port         = var.rabbitmq_ports_vpn[count.index]
  to_port           = var.rabbitmq_ports_vpn[count.index]
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "rabbitmq_acceptingConnectionFrom_payment" {
  type              = "ingress"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id = module.rabbitmq.sg_id
}

#************* Catalogue SUCURITY GROUP RULES ****************

resource "aws_security_group_rule" "catalogue_acceptingConnectionFrom_openvpn" {
  
  type              = "ingress"
  from_port         = 22
  to_port           = 22
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

resource "aws_security_group_rule" "catalogue_acceptingConnectionFrom_openvpn_http" {
  
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.catalogue.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

resource "aws_security_group_rule" "catalogue_acceptingConnectionFrom_backend_alb" {
  
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.catalogue.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

#*************** User sucurity group rules ******************

resource "aws_security_group_rule" "user_acceptingConnectionFrom_openvpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.user.sg_id
}

resource "aws_security_group_rule" "user_acceptingConnectionFrom_bastion_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.user.sg_id
}

resource "aws_security_group_rule" "user_acceptingConnectionFrom_openvpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.user.sg_id
}

resource "aws_security_group_rule" "user_acceptingConnectionFrom_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.user.sg_id
}

#************** Cart security group rules ****************

resource "aws_security_group_rule" "cart_acceptingConnectionFrom_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_acceptingConnectionFrom_bastion_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_acceptingConnectionFrom_bastion_openvpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_acceptingConnectionFrom_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.cart.sg_id
}

# ***************** Shipping sucurity group rules ************************

resource "aws_security_group_rule" "shipping_acceptingConnectionFrom_openvpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "shipping_acceptingConnectionFrom_bastion_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "shipping_acceptingConnectionFrom_openvpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "shipping_acceptingConnectionFrom_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.shipping.sg_id
}

#************** Payment security group rules ******************

resource "aws_security_group_rule" "payment_acceptingConnectionFrom_openvpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.payment.sg_id
}

resource "aws_security_group_rule" "payment_acceptingConnectionFrom_bastion_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.payment.sg_id
}

resource "aws_security_group_rule" "payment_acceptingConnectionFrom_openvpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.payment.sg_id
}

resource "aws_security_group_rule" "payment_acceptingConnectionFrom_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.payment.sg_id
}

#***************** Backend ALB security grou rules ******************

# backend ALB accepting connections from my openvpn host on port no 80
resource "aws_security_group_rule" "backend_alb_acceptingConnectionFrom_openvpn" {
  type              = "ingress"
  from_port         = 80 
  to_port           = 80 
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.backend_alb.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

# backend ALB accepting connections from my bastion host on port no 80
resource "aws_security_group_rule" "backend_alb_acceptingConnectionFrom_bastion" {
  type              = "ingress"
  from_port         = 80 
  to_port           = 80 
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id # traffic source is comming from bastion, so givinig bastion sg_id, Only Bastion Host SG can access Backend ALB, This is SG-to-SG communication and Very important in real-time projects.
  security_group_id = module.backend_alb.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

resource "aws_security_group_rule" "backend_alb_acceptingConnectionFrom_bastion_frontend-sg" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend-sg.sg_id
  security_group_id = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "backend_alb_acceptingConnectionFrom_bastion_cart" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "backend_alb_acceptingConnectionFrom_shipping" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "backend_alb_acceptingConnectionFrom_payment" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id = module.backend_alb.sg_id
}

#*************** Frontend security group rules ***********************

resource "aws_security_group_rule" "frontend-sg_acceptingConnectionFrom_openvpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.frontend-sg.sg_id
}

resource "aws_security_group_rule" "frontend_acceptingConnectionFrom_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.frontend-sg.sg_id
}

resource "aws_security_group_rule" "frontend_acceptingConnectionFrom_frontend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend_alb.sg_id
  security_group_id = module.frontend-sg.sg_id
}

# ********** Frontend ALB security group rules ************************

resource "aws_security_group_rule" "frontend_alb_acceptingConnectionFrom_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.backend_alb.sg_id #this backend_alb should be replaced with frontend_alb, but shiva has written like this need to see , while execution.?
}

resource "aws_security_group_rule" "frontend_alb_acceptingConnectionFrom_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend_alb.sg_id
}

resource "aws_security_group_rule" "bastion_acceptingConnectionFrom_laptop" {
  type              = "ingress"
  from_port         = 22 #need to login sequrely, so we are using or opening only port 22[ssh]
  to_port           = 22 #need to login sequrely, so we are using or opening only port 22[ssh]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] #for present, i am giving allow all puclic
  security_group_id = module.bastion.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha.
}

#***************** VPN ports 22, 443, 1194, 943 security group rules from public acccess[0.0.0.0/0] **************


resource "aws_security_group_rule" "openvpn_acceptingConnectionFrom_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22 
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.openvpn.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

#Optional VPN over HTTPS
resource "aws_security_group_rule" "openvpn_acceptingConnectionFrom_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.openvpn.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}
# Port 1194 is the default OpenVPN port. We create an ingress rule on port 1194 so VPN clients on the Internet can connect to the OpenVPN server in public subnet. The rule 0.0.0.0/0 allows connections from any public IP. Once connected, users can securely access private resources inside the VPC through the VPN tunnel.
#VPN Tunnel Connections
resource "aws_security_group_rule" "openvpn_acceptingConnectionFrom_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.openvpn.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}

#OpenVPN Web UI (Admin/User Portal)
#Port 943 is used by OpenVPN Access Server's web interface. It provides the admin dashboard and user portal for downloading VPN profiles and managing VPN users. Security group ingress on TCP 943 allows administrators and users to access the OpenVPN web console through a browser.
resource "aws_security_group_rule" "openvpn_acceptingConnectionFrom_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.openvpn.sg_id # this sg_id comes from the outputs.tf file from the Module-terraform-aws-securitygroup, which ll be kept in SSM Parameter, then we ll use this, which ever repo is needed, but to keep in ssm parameter, is need to be done by 10-securitygroup badhyatha. This rule is attached to Backend ALB security group
}



