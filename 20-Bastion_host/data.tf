# Data Source: aws_ami  terraform ,type in goolgle 

data "aws_ami" "joindevops" {
    owners           = ["973714476881"] # this one i ll get in the ami details
    most_recent      = true # always if any updates latest, we ll take lastest , so its true

    /* filter {
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
 */
    
  
}



# search google -> SSM Parameter data source terraform

data "aws_ssm_parameter" "bastion_sg_id" {
  #name = "/${var.project}/${var.environment}/bastion_sg_id" #this is the one need to use actually, right now i am getting error , so using this.
  name = "/roboshop-sg-27may-2026/dev-sg-27may-2026/bastion_sg_id"
  
  
}

# search google -> SSM Parameter data source terraform
#public_subnet_ids
# i ll get here 2 public subnets, i need 1 st one[us-east-1a, for this check in locals, i have used split function, which is opposite to join function, where it will change string to list, in that we will take first 1, for ex:jkasgdhfgjshkfjds,jshdhfkjhshf  ->[jkasgdhfgjshkfjds,jshdhfkjhshf]-> here in this we will take first one, where i will keep my bastion host/server as  which ll be used in the main.tf, of subnet_id
data "aws_ssm_parameter" "public_subnet_ids" {
  #name = "/${var.project}/${var.environment}/public_subnet_ids" #this is the one need to use actually, right now i am getting error , so using this.
  name = "/roboshop-vpc-may27-2026/dev-vpc-may27-2026/public_subnet_ids"
  
  
}