# in google aws target group terraform resource code

resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project}-${var.environment}-catalogue-tgt-grp" #roboshop-dev-catalogue[dates will be added check.12sept-2026]
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id # Replace with your VPC ID
  #target_type = "instance"
  # ⏱️ Set deregistration delay in seconds (Default is 300)
  #target group lo nunchi instances ni tisettapudu, 2mins time istundi instances ki
  deregistration_delay = 120

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
  ami                    = local.ami_id # refers locals for more info
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  # Giving public subnet id from local for more info, keeping bastion host in this first subnet id - [us-east-1a]
  subnet_id = local.private_subnet_id

  # UPDATE THIS LINE TO USE THE DYNAMIC ATTRIBUTE:
  #iam role which we created in iam, which is non human role, with user credentials
  #iam_instance_profile   = "EC2RoleToFetchSSMParams"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue"
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
    source      = "catalogue.sh"      # Local file location
    destination = "/tmp/catalogue.sh" # Remote path on the instance
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
      "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"

    ]
  }
}

# 1)stopping the instance
# after creating instanca creation and ansible configuration, we are stopping the instance to take the ami details.
resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on  = [terraform_data.catalogue] # this means, we are depeding on the terraform_data, to configure completely through ansible pull, once done , we are goinf to stop the instance.
}


#2) taking the ami of instance , here catalogue
resource "aws_ami_from_instance" "catalogue" {
  name               = "${var.project}-${var.environment}-catalogue-ami"
  source_instance_id = aws_instance.catalogue.id
  depends_on         = [aws_ec2_instance_state.catalogue] #once instance is stopped we will take the ami, so it depends on stopping the instance above, when ansible pull completes.
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue-ami"
    }
  )
}

# 3) Vunna instance [catalogue ] ni delete cheya, daniki terraform code ledu, we will use command line for this

#The null_resource in Terraform is a resource that implements the standard Terraform lifecycle but does not provision or manage any actual infrastructure in your cloud environment. It exists purely within your Terraform state file as an orchestration anchor
resource "terraform_data" "catalogue_delete" {
  # Triggers replacement (destruction and recreation) if the instance ID changes
  triggers_replace = [
    aws_instance.catalogue.id
  ]

  #here make sure , you have aws configure in you laptop, i have done in repos no problem, and i have downloaded the aws cli also, while downloading terraform
  #local exec to stop the catalogue instance
  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.catalogue.id}"
  }

  depends_on = [aws_ami_from_instance.catalogue] # once we take ami, we will stop the the instance, so its depending on step 2.
}

# **************** aws lauch template **************

resource "aws_launch_template" "catalogue_launch_template" {
  name_prefix = "${var.project}-${var.environment}-catalogue-launch-template" #
  image_id    = aws_ami_from_instance.catalogue.id
  # Added Shutdown Behavior
  instance_initiated_shutdown_behavior = "terminate" #when traffic decrease, the ASG will terminate the instances.
  instance_type                        = "t3.micro"

  # Updated: Top-level this lauch template is for catalogue , so given catalogue security group.
  vpc_security_group_ids = [local.catalogue_sg_id]

  # Automatically sets the newest version of ami as the default version
  update_default_version = true #each time we update ami, new version will become default.



  # this tags is for for ec2 instance tags.
  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.common_tags,
      {
        Name = "${var.project}-${var.environment}-catalogue-launch-template"
      }
    )
  }

  # this tags is for for volume tags of that instance.
  tag_specifications {
    resource_type = "volume"

    tags = merge(
      local.common_tags,
      {
        Name = "roboshop-dev-12spt-catalogue-launch-template"
      }
    )
  }

  # launch template tags
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue-launch-template"
    }
  )
}

# *********** Auto Scalling Group  and attaching the Launch temoplate created above ****************

resource "aws_autoscaling_group" "catalogue_ASG" {
  name_prefix      = "${var.project}-${var.environment}-catalogue-ASG"
  desired_capacity = 1
  max_size         = 10
  min_size         = 1

  # target_group_arns means -> attching this ASG instances to targrt group.
  # Added: Connects your ASG to your Load Balancer's Target Group
  target_group_arns = [aws_lb_target_group.catalogue.arn]

  #, this ASG will lauched into the this private subnet id, when one private -1a subnet id is having issue means, ASG will launch in private 1b
  vpc_zone_identifier = local.private_subnet_ids # Replace with your Subnet IDs

  # Added: Health Check Configurations BY ALB
  health_check_type         = "ELB" # Uses Target Group checks instead of just EC2 hardware status
  health_check_grace_period = 90    # Gives instances 90S to boot up before checking health

  # Taking the latest lauch template when refresh happens.
  # When you update your Launch Template (for example, changing the AMI or instance type), Instance Refresh automatically terminates the old instances and spins up new instances running your latest configuration inside the Auto Scaling Group.
  launch_template {
    id      = aws_launch_template.catalogue_launch_template.id # Replace with your Launch Template ID
    version = aws_launch_template.catalogue_launch_template.latest_version
  }

  # for tag in ASG, we are using dynamic block, because, we should use only tag here, so for in ASG, we should use one one tag seperately, thats y using dynamic block.
  dynamic "tag" {
    for_each = merge(
      local.common_tags,
      {
        Name = "${var.project}-${var.environment}-catalogue-ASG"
      }
    )
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true

    }

  }

  #This block tells AWS how to safely update your running EC2 instances with zero downtime whenever you change your Launch Template.
  # Added: Instance Refresh Configuration
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50 # Keeps at least half your instances healthy during update

    }
    triggers = ["launch_template"] # Automatically triggers refresh if tags or launch templates change
  }

  # WHILE CRETING AND DELETING IN ASG it will take more time, so, we are specifying some time here.
  timeouts {

    delete = "15m" # max 15 mins lopala delete avvali insatances
  }

}

# ********AUTO SCALLING GROUP POLICY *************

# avg cpu of instances we are taking in auto scalling policy

resource "aws_autoscaling_policy" "catalogue_avgcpu" {
  name                   = "${var.project}-${var.environment}-catalogue-avgcpu"
  autoscaling_group_name = aws_autoscaling_group.catalogue_ASG.name
  policy_type            = "TargetTrackingScaling"

  #default_cooldown = 120 #not supported in this version so used below.
  estimated_instance_warmup = 120 #This is not the same as cooldown; it tells Auto Scaling how long a newly launched instance needs before its metrics are considered for scaling decisions.

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0 # Keeps average CPU usage at 75%
  }
}

# ********** ALB Listner RULE *******************
resource "aws_lb_listener_rule" "catalogue_rule" {
  listener_arn = local.backend_alb_listener_arn # Replace with your ALB Listener ARN
  priority     = 10                             # Rules are evaluated in order from lowest number to highest

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  # Condition block determines when this rule triggers
  condition {
    host_header {
      values = ["catalogue.backend-${var.environment}.${var.zone_name}"] #catalogue.backend-dev.karthikeya.site
    }
  }
}


