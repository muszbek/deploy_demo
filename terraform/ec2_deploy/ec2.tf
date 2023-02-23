module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  availability_zone = module.vpc.azs[0]
  subnet_id = module.vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.http_sg.id, aws_security_group.ssh_sg.id]
  key_name = aws_key_pair.ec2.name

  # 22.04 Ubuntu amd64 in eu-west-1
  ami = "ami-0d2f9b5f04091bdb7"
  instance_type = "t2.micro"
}

variable "PUBLIC_KEY" {
  description = "ssh public key to connect to the ec2 instance - not a secret"
  type = string
}

resource "aws_key_pair" "ec2" {
  key_name = "ec2_ssh_key"
  public_key = var.PUBLIC_KEY
}

resource "aws_ebs_volume" "volume" {
  availability_zone = module.vpc.azs[0]
  size = 1
}

resource "aws_volume_attachment" "attach" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.volume.id
  instance_id = module.ec2.id
}
