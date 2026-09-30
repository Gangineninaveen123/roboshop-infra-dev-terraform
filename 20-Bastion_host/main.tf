# search google -> aws instance terraform
#here mainly Bastion_host ll ec2 instance ll create in public_subnet.
resource "aws_instance" "bastion" {
  ami           = local.ami_id # refers locals for more info
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  # Giving public subnet id from local for more info, keeping bastion host in this first subnet id - [us-east-1a]
  subnet_id = local.public_subnet_id

  # By default ami ll take 20 GB memory , so given extra memory, which need more for terraform[like terraform commands in bastion, while connecting to components and databases.]
  # This 50 GB will not work, we need to mount the filesystem to path, thenly only we can use this 50 GB.
  root_block_device {
    volume_size = 90
    volume_type = "gp3" # or "gp2", depending on your preference
  }

  user_data = file("bastion.sh")
  iam_instance_profile = "TerraformAdmin"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-Bastion_Host_in_Public_subnet_in_frontend"
    }
  )
}