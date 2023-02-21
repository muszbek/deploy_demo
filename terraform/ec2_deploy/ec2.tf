module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  #availability_zone = module.vpc.azs[0]
  subnet_id = module.vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.http_sg.id, aws_security_group.ssh_sg.id]
  
  ami = "ami-0df17c76c2f2c426d"
  instance_type = "t2.micro"
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
