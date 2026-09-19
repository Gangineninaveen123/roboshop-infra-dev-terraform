/* #********** thi i iam role cfreated , beacuse previously is not taking the ssm parameter of mysql root password, no after adding iam role its works, my sql took mysql root password , by the iam user cooncets to ssm parameter and tooks.****************
# 1. Create an IAM Role for EC2
resource "aws_iam_role" "mysql_ssm_role" {
  name = "${var.project}-${var.environment}-mysql-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" # <-- Fixed the broken string here
        }
      }
    ]
  })
}

# 2. Attach the SSM Managed Policy to the Role
resource "aws_iam_role_policy_attachment" "ssm_policy_attach" {
  role       = aws_iam_role.mysql_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# 3. Create the Instance Profile Profile wrapper
resource "aws_iam_instance_profile" "mysql_profile" {
  name = "${var.project}-${var.environment}-mysql-ssm-profile"
  role = aws_iam_role.mysql_ssm_role.name
} */

#***************** IAM ROLE DONE **************************

# search google -> aws instance terraform
#here mainly mongodb_host ll ec2 instance ll create in public_subnet.
resource "aws_instance" "mongodb" {
  ami           = local.ami_id # refers locals for more info
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mongodb_sg_id]
  # Giving public subnet id from local for more info, keeping bastion host in this first subnet id - [us-east-1a]
  subnet_id = local.database_subnet_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-mongodb_Host_in_database_subnet_in_DB"
    }
  )
}

#The null_resource in Terraform is a resource that implements the standard Terraform lifecycle but does not provision or manage any actual infrastructure in your cloud environment. It exists purely within your Terraform state file as an orchestration anchor
resource "terraform_data" "mongodb" {
  # Triggers replacement (destruction and recreation) if the instance ID changes
  triggers_replace = [
    aws_instance.mongodb.id
  ]

#The Terraform file provisioner is used to copy files or directories from the machine running Terraform onto a newly created remote resource (like an EC2 instance).
  provisioner "file" {
    #bootstrap -> all datbase and backend microservices names u can consider.
    source      = "bootstrap.sh"       # Local file location
    destination = "/tmp/bootstrap.sh"       # Remote path on the instance
  }


  # it  is remote-exec [provisoner], after creating server, ll connect to it, with the help of connection

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip 
  }

  ## [remote-exec] -> means, after creating server, we ll run the teraform commands on created servers.....ex:- ec2
#now what to do, after connecting to server with public ip adress with [remote-exec]
# note -> its in creation time
  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh mongodb"
      
    ]
  }
}

#creating route 53 records for mongodb.
resource "aws_route53_record" "mongodb" {
  zone_id = var.zone_id
  name    = "mongodb.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
  allow_overwrite = true
}

#*******redis****************
# search google -> aws instance terraform
#here mainly mongodb_host ll ec2 instance ll create in public_subnet.
resource "aws_instance" "redis" {
  ami           = local.ami_id # refers locals for more info
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.redis_sg_id]
  # Giving public subnet id from local for more info, keeping bastion host in this first subnet id - [us-east-1a]
  subnet_id = local.database_subnet_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-redis_Host_in_database_subnet_in_DB"
    }
  )
}

#The null_resource in Terraform is a resource that implements the standard Terraform lifecycle but does not provision or manage any actual infrastructure in your cloud environment. It exists purely within your Terraform state file as an orchestration anchor
resource "terraform_data" "redis" {
  # Triggers replacement (destruction and recreation) if the instance ID changes
  triggers_replace = [
    aws_instance.redis.id
  ]

#The Terraform file provisioner is used to copy files or directories from the machine running Terraform onto a newly created remote resource (like an EC2 instance).
  provisioner "file" {
    #bootstrap -> all datbase and backend microservices names u can consider.
    source      = "bootstrap.sh"       # Local file location
    destination = "/tmp/bootstrap.sh"       # Remote path on the instance
  }


  # it  is remote-exec [provisoner], after creating server, ll connect to it, with the help of connection

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip 
  }

  ## [remote-exec] -> means, after creating server, we ll run the teraform commands on created servers.....ex:- ec2
#now what to do, after connecting to server with public ip adress with [remote-exec]
# note -> its in creation time
  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh redis"
      
    ]
  }
}

#creating route 53 records for redis.
resource "aws_route53_record" "redis" {
  zone_id = var.zone_id
  name    = "redis.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.redis.private_ip]
  allow_overwrite = true
}
#*******mysql****************
# search google -> aws instance terraform
#here mainly mysql_host ll ec2 instance ll create in public_subnet.
resource "aws_instance" "mysql" {
  ami           = local.ami_id # refers locals for more info
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mysql_sg_id]
  # Giving public subnet id from local for more info, keeping bastion host in this first subnet id - [us-east-1a]
  subnet_id = local.database_subnet_id
  
  # UPDATE THIS LINE TO USE THE DYNAMIC ATTRIBUTE:
  #iam role which we created in iam, which is non human role, with user credentials
  iam_instance_profile   = "EC2RoleToFetchSSMParams"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-mysql_Host_in_database_subnet_in_DB"
    }
  )
}

#The null_resource in Terraform is a resource that implements the standard Terraform lifecycle but does not provision or manage any actual infrastructure in your cloud environment. It exists purely within your Terraform state file as an orchestration anchor
resource "terraform_data" "mysql" {
  # Triggers replacement (destruction and recreation) if the instance ID changes
  triggers_replace = [
    aws_instance.mysql.id
  ]

#The Terraform file provisioner is used to copy files or directories from the machine running Terraform onto a newly created remote resource (like an EC2 instance).
  provisioner "file" {
    #bootstrap -> all datbase and backend microservices names u can consider.
    source      = "bootstrap.sh"       # Local file location
    destination = "/tmp/bootstrap.sh"       # Remote path on the instance
  }


  # it  is remote-exec [provisoner], after creating server, ll connect to it, with the help of connection

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mysql.private_ip 
  }

  ## [remote-exec] -> means, after creating server, we ll run the teraform commands on created servers.....ex:- ec2
#now what to do, after connecting to server with public ip adress with [remote-exec]
# note -> its in creation time
  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh mysql"
    ]
  }
}


#creating route 53 records for mysql.
resource "aws_route53_record" "mysql" {
  zone_id = var.zone_id
  name    = "mysql.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mysql.private_ip]
  allow_overwrite = true
}

#***********************
# search google -> aws instance terraform
#here mainly mysql_host ll ec2 instance ll create in public_subnet.
resource "aws_instance" "rabbitmq" {
  ami           = local.ami_id # refers locals for more info
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.rabbitmq_sg_id]
  # Giving public subnet id from local for more info, keeping bastion host in this first subnet id - [us-east-1a]
  subnet_id = local.database_subnet_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-rabbitmq_Host_in_database_subnet_in_DB"
    }
  )
}

#The null_resource in Terraform is a resource that implements the standard Terraform lifecycle but does not provision or manage any actual infrastructure in your cloud environment. It exists purely within your Terraform state file as an orchestration anchor
resource "terraform_data" "rabbitmq" {
  # Triggers replacement (destruction and recreation) if the instance ID changes
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]

#The Terraform file provisioner is used to copy files or directories from the machine running Terraform onto a newly created remote resource (like an EC2 instance).
  provisioner "file" {
    #bootstrap -> all datbase and backend microservices names u can consider.
    source      = "bootstrap.sh"       # Local file location
    destination = "/tmp/bootstrap.sh"       # Remote path on the instance
  }


  # it  is remote-exec [provisoner], after creating server, ll connect to it, with the help of connection

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.rabbitmq.private_ip 
  }

  ## [remote-exec] -> means, after creating server, we ll run the teraform commands on created servers.....ex:- ec2
#now what to do, after connecting to server with public ip adress with [remote-exec]
# note -> its in creation time
  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh rabbitmq"
      
    ]
  }
}

#creating route 53 records for rabbitmq.
resource "aws_route53_record" "rabbitmq" {
  zone_id = var.zone_id
  name    = "rabbitmq.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.rabbitmq.private_ip]
  allow_overwrite = true
}