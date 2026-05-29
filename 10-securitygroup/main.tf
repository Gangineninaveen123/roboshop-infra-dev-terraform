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