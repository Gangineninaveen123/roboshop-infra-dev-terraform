# search google -> SSM Parameter data source terraform

data "aws_ssm_parameter" "vpc_id" {
  #name = "/${var.project}/${var.environment}/vpc_id", its showing wrong path, while craeting resousorce, so thts y, given direct name
  name = "/roboshop-vpc-may27-2026/dev-vpc-may27-2026/vpc_id"
  
}
