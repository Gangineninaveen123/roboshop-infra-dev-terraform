# in google aws target group terraform resource code

resource "aws_lb_target_group" "catalogue" {
  name        = "roboshop-dev-12spt-catalogue" #roboshop-dev-catalogue[dates will be added check.12sept-2026]
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = local.vpc_id # Replace with your VPC ID
  #target_type = "instance"

  health_check {
    #enabled             = true
    path                = "/health"
    protocol            = "HTTP"
    port                = 8080
    interval            = 5
    timeout             = 2
    healthy_threshold   = 2
    unhealthy_threshold = 3
    matcher             = "200-299"
  }

  /* tags = {
    Environment = "dev"
  } */
}

resource "aws_instance" "catalogue" {
  ami           = local.ami_id # refers locals for more info
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  # Giving public subnet id from local for more info, keeping bastion host in this first subnet id - [us-east-1a]
  subnet_id = local.private_subnet_id
  
  # UPDATE THIS LINE TO USE THE DYNAMIC ATTRIBUTE:
  #iam role which we created in iam, which is non human role, with user credentials
  #iam_instance_profile   = "EC2RoleToFetchSSMParams"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue_Host_in_private_subnet"
    }
  )
} 

#The null_resource in Terraform is a resource that implements the standard Terraform lifecycle but does not provision or manage any actual infrastructure in your cloud environment. It exists purely within your Terraform state file as an orchestration anchor
resource "terraform_data" "catalogue" {
  # Triggers replacement (destruction and recreation) if the instance ID changes
  triggers_replace = [
    aws_instance.catalogue.id
  ]

#The Terraform file provisioner is used to copy files or directories from the machine running Terraform onto a newly created remote resource (like an EC2 instance).
  provisioner "file" {
    #bootstrap -> all datbase and backend microservices names u can consider.
    source      = "catalogue.sh"       # Local file location
    destination = "/tmp/catalogue.sh"       # Remote path on the instance
  }


  # it  is remote-exec [provisoner], after creating server, ll connect to it, with the help of connection

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip 
  }

  ## [remote-exec] -> means, after creating server, we ll run the teraform commands on created servers.....ex:- ec2
#now what to do, after connecting to server with public ip adress with [remote-exec]
# note -> its in creation time
  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/catalogue.sh",
        "sudo sh /tmp/catalogue.sh catalogue"
      
    ]
  }
}


/* resource "aws_instance" "catalogue" {
  ami                    = local.ami_id 
  instance_type          = "t3.micro"
  
  # Correct: Always use security group IDs inside a VPC subnet
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id              = local.private_subnet_id
  
  # Ensure NO line containing "security_groups = ..." exists below this point

  tags = merge(
    local.common_tags,
    {
      Name = "roboshop-dev-catalogue"
    }
  )
}  */

/* resource "aws_instance" "catalogue" {
  ami                    = local.ami_id 
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id              = local.private_subnet_id
  
  # Runs the script internally during boot up
  user_data = templatefile("catalogue.sh", { component = "catalogue" })

  tags = merge(
    local.common_tags,
    {
      Name = "roboshop-dev-catalogue"
    }
  )
}
 */



