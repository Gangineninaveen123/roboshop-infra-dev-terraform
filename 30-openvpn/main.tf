
# Currently this resource requires an existing user-supplied key pair. This key pair's public key will be registered with AWS to allow logging-in to EC2 instances.
resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn"
  public_key = file("C:\\Devops\\daws-84s\\openvpn.pub") #windows path, to keep in aws account the opnvpn public key, , which, when we search in keys, it should appear, then it is imported in aws account
}

# search google -> aws instance terraform
#here mainly vpn_host ll ec2 instance ll create in public_subnet.
resource "aws_instance" "vpn" {
  ami           = "ami-04210df84866a6f22"
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.vpn_sg_id]
  # Giving public subnet id from local for more info, keeping vpn host in this first subnet id - [us-east-1a]
  subnet_id = local.public_subnet_id
  key_name = aws_key_pair.openvpn.key_name #make sure this key exists in AWS
  #key_name = "daws-84s" # if key is already in aws account, ignore above code aws_key_pair resource
  user_data = file("openvpn.sh") # no need of entering username and paswords manually, the openvpn.sh script only ll launch, through code, because, it hasve all the passwords.

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-vpn_Host_in_Public_subnet_in_frontend"
    }
  )
}

#creating route 53 records for openvpn.
resource "aws_route53_record" "openvpn" {
  zone_id = var.zone_id
  name    = "openvpn-dev.${var.zone_name}" #record is openvpn-dev.karthikeya.site
  type    = "A"
  ttl     = 1
  records = [aws_instance.vpn.public_ip]
  allow_overwrite = true
}
