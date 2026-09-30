#1) APPLICATION LOAD BALANCER CREATION

module "frontend_alb" {
  source = "terraform-aws-modules/alb/aws" # this is open source modules, so, no need to mention git, it ll connect directly to git and takes the information from it. from google., no need of writing code manually
  version = "9.7.0" #here for this ALB oPEN SOURCE Module is accepting the version >=9.7.0, so for this we are giving the version here only, other wise we need to install new terraform version, simpley we are giving here only.
  #if i give name with project and environment, its going more that 32 characterter, while doing terraform plan, so giving manually.
  #name    = "${var.project}-${var.environment}-backend-alb" #roboshop-dev-backend-alb[roboshop-dev-bknd-alb]
  name = "${var.project}-${var.environment}-frontend-alb"
  vpc_id  = local.vpc_id # through data source we got vpc, as its comes from 10-securitygroup - for 10-secutitygroup , it comes from 01-VPC[HERE, we are storing in SSM Parameter store], for 01-vpc, it comes from module outputs - module terraform aws vpc.
  subnets = local.public_subnet_ids ## through data source we got private_subnet_ids, as its comes from 01-vpc - [HERE, we are storing in SSM Parameter store],and we are using in 50-backend_alb, through datasource , and it comes from module outputs - module terraform aws vpc.

  internal = false # Load Balancer is PRIVATE, It works only inside VPC/internal network and Internet users cannot access it directly.
  # -> Security Group rule3s, we atre not giving, because already we have created in 10-securitygroup folder.
 
 
 # 1)Here in module, they have given create_security_goup as true, as default sg, this one defenitely we need to check in the module
 # 2)here we have created our own security group, so taking it,thats why we are keeping create_security_group as false.
 create_security_group = false

# this security group id, ll come through data source again. it is a list 
 security_groups = [local.frontend_alb_sg_id]
 enable_deletion_protection = false 
 

 

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-frontend-alb"

    }
  )
}


#2) HTTPS Listener for ALB [so here, listner all add to our ALB{Aplication Load Balancer}]

resource "aws_lb_listener" "frontend_alb" {

  load_balancer_arn = module.frontend_alb.arn #arn(Amazon Resource Name) is the unique identity/address of an AWS resource. this is one in load balancer[arn:aws:elasticloadbalancing:us-east-1:227896186429:loadbalancer/app/roboshop-dev-may27-backend-alb/f731bed7bb1ca3f5]

  port     = 443
  protocol = "HTTPS"
  # Recommended modern AWS SSL Policy (TLS 1.2 minimum)
  #ssl_policy       = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  ssl_policy       = "ELBSecurityPolicy-2016-08"
  
  # References the ARN from the acm validation resource created earlier
  certificate_arn  = local.acm_certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, frontend ALB Working good with status HTTPS <h1/>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "frontend_alb" {
  zone_id = var.zone_id
  name    = "${var.environment}.${var.zone_name}" # dev.karthikeya.site for route 53 recors, for frontend-alb
  type    = "A"

  alias {
    name                   = module.frontend_alb.dns_name    #[dns_name -> this dns name comes from outputs form open source module for frontend alb.] Target resource DNS name 
    zone_id                = module.frontend_alb.zone_id    # [zone_id -> this zone_id comes from outputs form open source module for frontend alb.]]
    evaluate_target_health = true
  }
}
