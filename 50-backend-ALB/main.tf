module "backend_alb" {
  source = "terraform-aws-modules/alb/aws" # this is open source modules, so, no nee to mention git, it ll connect directly to git and takes the information from it.

  name    = "${var.project}-${var.environment}-backend-alb" #roboshop-dev-backend-alb
  vpc_id  = local.vpc_id # through data source we got vpc, as its comes from 10-securitygroup - for 10-secutitygroup , it comes from 01-VPC[HERE, we are storing in SSM Parameter store], for 01-vpc, it comes from module outputs - module terraform aws vpc.
  subnets = local.private_subnet_ids ## through data source we got private_subnet_ids, as its comes from 01-vpc - [HERE, we are storing in SSM Parameter store],and we are using in 50-backend_alb, through datasource , and it comes from module outputs - module terraform aws vpc.

  # -> Security Group rule3s, we atre not giving, because already we have created in 10-securitygroup folder.
 
 
 # 1)Here in module, they have given create_security_goup as true, this one defenitely we need to check in the module
 # 2)here we have created our own security group, so tking it,thats why we are keeping create_security_goup as false.
 create_security_goup = false

# this security group id, ll come through data source again. it is a list 
 security_groups = [local.backend_alb_sg_id]

 

  tags = {
    Environment = "Development"
    Project     = "Example"
  }
}