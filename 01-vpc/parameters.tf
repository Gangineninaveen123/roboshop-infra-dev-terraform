#in google -> ssm parameter store terraform
resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project}/${var.environment}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id  # here to get vpc_id from outputs in module, its already came to our modules, beacause we are using that module, and last [vpc_id ], we should use same one which is used in the module, that is mandatory...
}


# Module vpc is giving, public_subnets,, now storing them in SSM Parameter for Bastion host/jump host ec2 , to keep in public subnets.
#in google -> ssm parameter store terraform
resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project}/${var.environment}/public_subnet_ids"
  type  = "StringList"
  # here in downside, i am making the list to string of public_subnet_ids
  # subnet-03e8400fc2b844d6c,subnet-09fcc9cda44bdb48c  # like this it ll store.
  value = join(",", module.vpc.public_subnet_ids)  # here to get public_subnet_ids from outputs.tf in module, its already came to our modules, beacause we are using that module, and last [public_subnet_ids ], we should use same one which is used in the module, that is mandatory...
}

# Module vpc is giving, private_subnet_ids,, now storing them in SSM Parameter for Bastion host/jump host ec2 , to keep in private subnets.
#in google -> ssm parameter store terraform
resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project}/${var.environment}/private_subnet_ids"
  type  = "StringList"
  # here in downside, i am making the list to string of private_subnet_ids
  # subnet-03e8400fc2b844d6c,subnet-09fcc9cda44bdb48c  # like this it ll store.
  value = join(",", module.vpc.private_subnet_ids)  # here to get private_subnet_ids from outputs.tf in module, its already came to our modules, beacause we are using that module, and last [private_subnet_ids ], we should use same one which is used in the module, that is mandatory...
}

# Module vpc is giving, database_subnet_ids,, now storing them in SSM Parameter for Bastion host/jump host ec2 , to keep in database subnets.
#in google -> ssm parameter store terraform
resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project}/${var.environment}/database_subnet_ids"
  type  = "StringList"
  # here in downside, i am making the list to string of database_subnet_ids
  # subnet-03e8400fc2b844d6c,subnet-09fcc9cda44bdb48c  # like this it ll store.
  value = join(",", module.vpc.database_subnet_ids)  # here to get database_subnet_ids from outputs.tf in module, its already came to our modules, beacause we are using that module, and last [database_subnet_ids ], we should use same one which is used in the module, that is mandatory...
}

