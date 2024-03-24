####################################################################
#                       EC2 Instance VPC 1                           
####################################################################

resource "aws_instance" "pub_subnet_vpc_1" {
  ami             = var.ami-vpn
  subnet_id       = aws_subnet.pub_subnet_vpc_1.id
  instance_type   = var.ec2_type
  key_name        = "vpc_1"
  security_groups = [aws_security_group.pub_sg.id]

  tags = {
    Name = "openvpn"
  }
}

resource "aws_instance" "pri_subnet_vpc_1" {
  ami             = var.ami
  subnet_id       = aws_subnet.pri_subnet_vpc_1.id
  instance_type   = var.ec2_type
  key_name        = "vpc_1"
  security_groups = [aws_security_group.pri_sg.id]

  tags = {
    Name = "vpc_1_private_ec2"
  }
}

####################################################################
#                       EC2 Instance VPC 2                           
####################################################################
resource "aws_instance" "pub_subnet_vpc_2" {
  ami             = var.ami
  subnet_id       = aws_subnet.pub_subnet_vpc_2.id
  instance_type   = var.ec2_type
  key_name        = "vpc_2"
  security_groups = [aws_security_group.pub_sg_vpc_2.id]

  user_data = file("wireguard.sh")

  tags = {
    Name = "Server Peer A"
  }
}


resource "aws_instance" "pri_subnet_vpc_2" {
  ami             = var.ami
  subnet_id       = aws_subnet.pri_subnet_vpc_2.id
  instance_type   = var.ec2_type
  key_name        = "vpc_2"
  security_groups = [aws_security_group.pri_sg_vpc_2.id]


  user_data = file("wireguard.sh")

  tags = {
    Name = "WireGuard_Server"
  }
}

####################################################################
#                       EC2 Instance VPC 3                           
####################################################################
resource "aws_instance" "pub_subnet_vpc_3" {
  ami             = var.ami
  subnet_id       = aws_subnet.pub_subnet_vpc_3.id
  instance_type   = var.ec2_type
  key_name        = "vpc_3"
  security_groups = [aws_security_group.pub_sg_vpc_3.id]


  user_data = file("wireguard.sh")

  tags = {
    Name = "Server Peer B"
  }
}

resource "aws_instance" "pri_subnet_vpc_3" {
  ami             = var.ami
  subnet_id       = aws_subnet.pri_subnet_vpc_3.id
  instance_type   = var.ec2_type
  key_name        = "vpc_3"
  security_groups = [aws_security_group.pri_sg_vpc_3.id]

  tags = {
    Name = "TeamSpeak Host"
  }
}



