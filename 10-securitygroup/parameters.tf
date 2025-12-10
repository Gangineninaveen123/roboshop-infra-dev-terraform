resource "aws_ssm_parameter" "frontend_sg_id" {
  name  = "/${var.project}/${var.environment}/frontend_sg_id"
  type  = "String"
  value = module.frontend-sg.sg_id # here to get sg_id from outputs, its already came to our modules, beacause we are using that module, and last [sg_id ], we should use same one which is used in the module, that is mandatory...
}