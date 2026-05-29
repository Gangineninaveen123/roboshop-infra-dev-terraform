#1) APPLICATION LOAD BALANCER CREATION

module "backend_alb" {
  source = "terraform-aws-modules/alb/aws" # this is open source modules, so, no need to mention git, it ll connect directly to git and takes the information from it. from google., no need of writing code manually
  version = "9.7.0" #here for this ALB oPEN SOURCE Module is accepting the version >=9.7.0, so for this we are giving the version here only, other wise we need to install new terraform version, simpley we are giving here only.
  name    = "${var.project}-${var.environment}-may27-backend-alb" #roboshop-dev-backend-alb
  vpc_id  = local.vpc_id # through data source we got vpc, as its comes from 10-securitygroup - for 10-secutitygroup , it comes from 01-VPC[HERE, we are storing in SSM Parameter store], for 01-vpc, it comes from module outputs - module terraform aws vpc.
  subnets = local.private_subnet_ids ## through data source we got private_subnet_ids, as its comes from 01-vpc - [HERE, we are storing in SSM Parameter store],and we are using in 50-backend_alb, through datasource , and it comes from module outputs - module terraform aws vpc.

  internal = true # Load Balancer is PRIVATE, It works only inside VPC/internal network and Internet users cannot access it directly.
  # -> Security Group rule3s, we atre not giving, because already we have created in 10-securitygroup folder.
 
 
 # 1)Here in module, they have given create_security_goup as true, as default sg, this one defenitely we need to check in the module
 # 2)here we have created our own security group, so taking it,thats why we are keeping create_security_group as false.
 create_security_group = false

# this security group id, ll come through data source again. it is a list 
 security_groups = [local.backend_alb_sg_id]

 

  tags = merge(
    local.common_tags,
    {
      Name = "roboshop-dev-may27-2026-backend-alb"

    }
  )
}


#2) HTTP Listener for ALB [so here, listner all add to our ALB{Aplication Load Balancer}]

resource "aws_lb_listener" "backend_alb" {

  load_balancer_arn = module.backend_alb.arn #arn(Amazon Resource Name) is the unique identity/address of an AWS resource. this is one in load balancer[arn:aws:elasticloadbalancing:us-east-1:227896186429:loadbalancer/app/roboshop-dev-may27-backend-alb/f731bed7bb1ca3f5]

  port     = 80
  protocol = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, Backend ALB Working good with status code 200 <h1/>"
      status_code  = "200"
    }
  }
}