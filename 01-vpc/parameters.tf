#in google -> ssm parameter store terraform
resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project}/${var.environment}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id  # here to get vpc_id from outputs, its already came to our modules, beacause we are using that module, and last [vpc_id ], we should use same one which is used in the module, that is mandatory...
}