# search google -> aws instance terraform
#here mainly Bastion_host ll ec2 instance ll create in public_subnet.
resource "aws_instance" "bastion" {
  ami           = local.ami_id # refers locals for more info
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  # Giving public subnet id from local for more info
  subnet_id = local.public_subnet_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-Bastion_Host_in_Public_subnet_in_frontend"
    }
  )
}