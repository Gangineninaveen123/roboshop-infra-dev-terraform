# Data Source: aws_ami  terraform ,type in goolgle 

data "aws_ami" "joindevops" {
    owners           = ["973714476881"] # this one i ll get in the ami details
    most_recent      = true # always if any updates latest, we ll take lastest , so its true

    filter {
        name   = "name"
        values = ["RHEL-9-DevOps-Practice"]
  }
    filter {

        name   = "root-device-type"
        values = ["ebs"]
  }

    filter {

        name   = "virtualization-type"
        values = ["hvm"]
  }    

    
  
}



# search google -> SSM Parameter data source terraform

data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/${var.project}/${var.environment}/bastion_sg_id"
  
}

# search google -> SSM Parameter data source terraform
#public_subnet_ids
# i ll get here 2 public subnets, i need 1 st one which ll be used in the main.tf, of subnet_id
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project}/${var.environment}/public_subnet_ids"
  
}