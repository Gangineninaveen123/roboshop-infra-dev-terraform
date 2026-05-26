# search google -> SSM Parameter data source terraform
# vpc id through data source
data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
  
}

#private subnbet ids, through data source.
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project}/${var.environment}/private_subnet_ids"
  
}

#backend_alb_sg_id, through data source., this data source , we are taking from ssm parameter, which, mainly 10-securitygorup folder, sends backend_alb_sg_id to SSM Parameter, and this backend_alb_sg_id comes from outputs of module [Module-terraform-aws-securitygroup]
data "aws_ssm_parameter" "backend_alb_sg_id" {
  name = "/${var.project}/${var.environment}/backend_alb_sg_id"
  
}

