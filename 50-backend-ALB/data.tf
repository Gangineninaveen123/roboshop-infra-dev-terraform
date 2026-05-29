# search google -> SSM Parameter data source terraform
# vpc id through data source
data "aws_ssm_parameter" "vpc_id" {
  
  #name = "/${var.project}/${var.environment}/vpc_id", its showing wrong path, while craeting resousorce, so thts y, given direct name
  name = "/roboshop-vpc-may27-2026/dev-vpc-may27-2026/vpc_id"
  
}

#private subnbet ids, through data source.
data "aws_ssm_parameter" "private_subnet_ids" {
  #name = "/${var.project}/${var.environment}/private_subnet_ids" #this is the one need to use actually, right now i am getting error , so using this.
  name = "/roboshop-vpc-may27-2026/dev-vpc-may27-2026/private_subnet_ids"  
  
  
}

#backend_alb_sg_id, through data source., this data source , we are taking from ssm parameter, which, mainly 10-securitygorup folder, sends backend_alb_sg_id to SSM Parameter, and this backend_alb_sg_id comes from outputs of module [Module-terraform-aws-securitygroup]
data "aws_ssm_parameter" "backend_alb_sg_id" {
  
  #name  = "/${var.project}/${var.environment}/backend_alb_sg_id" #this is the one need to use actually, right now i am getting error , so using this.
  name  = "/roboshop-sg-27may-2026/dev-sg-27may-2026/backend_alb_sg_id" ##this is the one need to use actually,
  
}

