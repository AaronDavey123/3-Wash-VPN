####################################################################
#                       Security Groups VPC_1                                
####################################################################

#################### Public Security Group #########################
resource "aws_security_group" "pub_sg" {
  name   = "pub_sg"
  vpc_id = aws_vpc.vpc_1.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_in" {
  security_group_id = aws_security_group.pub_sg.id

  cidr_ipv4   = var.internet_access
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"

  tags = {
    Name = "allow in HTTPs"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allow_ssh_in" {
  security_group_id = aws_security_group.pub_sg.id

  cidr_ipv4   = var.internet_access
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  tags = {
    Name = "allow in SSH"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_udp_in" {
  security_group_id = aws_security_group.pub_sg.id

  cidr_ipv4   = var.internet_access
  from_port   = 1194
  to_port     = 1194
  ip_protocol = "udp"

  tags = {
    Name = "allow in udp"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tcp_in" {
  security_group_id = aws_security_group.pub_sg.id

  cidr_ipv4   = var.internet_access
  from_port   = 943
  to_port     = 943
  ip_protocol = "tcp"

  tags = {
    Name = "allow in tcp"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_out_to_vpc_1_pri" {
  security_group_id = aws_security_group.pub_sg.id

  cidr_ipv4 = var.cidr_pri_subnet_vpc_1
  from_port = "0"
  to_port = "0"
  ip_protocol = "-1"

  tags = {
    Name = "allow all traffic out to private subnet"
  }
  
}

#################### Private Security Group #########################

resource "aws_security_group" "pri_sg" {
  name   = "pri_sg"
  vpc_id = aws_vpc.vpc_1.id

}

resource "aws_vpc_security_group_ingress_rule" "allow_in_22" {
  security_group_id = aws_security_group.pri_sg.id

  cidr_ipv4   = var.internet_access
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  tags = {
    Name = "Allow SSH Out"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_out_HTTP" {
  security_group_id = aws_security_group.pri_sg.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 80
  to_port        = 80
  ip_protocol    = "tcp"

  tags = {
    Name = "Allow HTTP out"
  }

}

resource "aws_vpc_security_group_egress_rule" "allow_out_to_vpc_2_pub" {
  security_group_id = aws_security_group.pri_sg.id

  cidr_ipv4 = var.cidr_pub_subnet_vpc_2
  from_port = "0"
  to_port = "0"
  ip_protocol = "-1"

  tags = {
    Name = "allow all traffic out to vpc 2 public subnet"
  }
}


####################################################################
#                       Security Groups VPC_2                             
####################################################################

#################### Public Security Group #########################
resource "aws_security_group" "pub_sg_vpc_2" {
  name   = "pub_sg_vpc_2"
  vpc_id = aws_vpc.vpc_2.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_22_vpc_2_pub" {
  security_group_id = aws_security_group.pub_sg_vpc_2.id

  cidr_ipv4   = var.internet_access
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  tags = {
    Name = "Allow SSH In"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_vpn_vpc_2_pub" {
  security_group_id = aws_security_group.pub_sg_vpc_2.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 51820
  to_port        = 51820
  ip_protocol    = "udp"

  tags = {
    Name = "Allow Custom UDP"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_443_vpc_2_pub" {
  security_group_id = aws_security_group.pub_sg_vpc_2.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 443
  to_port        = 443
  ip_protocol    = "tcp"

  tags = {
    Name = "Allow HTTPS In"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_53_vpc_2_pub" {
  security_group_id = aws_security_group.pub_sg_vpc_2.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 53
  to_port        = 53
  ip_protocol    = "udp"

  tags = {
    Name = "Allow UDP In"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_out_51820_vpc_2_pub" {
  security_group_id = aws_security_group.pub_sg_vpc_2.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 51820
  to_port        = 51820
  ip_protocol    = "udp"

  tags = {
    Name = "Allow udp out of 51820"
  }
}


#################### Private Security Group #########################
resource "aws_security_group" "pri_sg_vpc_2" {
  name   = "Wireguard_sg"
  vpc_id = aws_vpc.vpc_2.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_22_vpc_2_pri" {
  security_group_id = aws_security_group.pri_sg_vpc_2.id

  cidr_ipv4   = var.internet_access
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  tags = {
    Name = "Allow SSH In"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_vpn_vpc_2_pri" {
  security_group_id = aws_security_group.pri_sg_vpc_2.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 51820
  to_port        = 51820
  ip_protocol    = "udp"

  tags = {
    Name = "Allow Custom UDP"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_443_vpc_2_pri" {
  security_group_id = aws_security_group.pri_sg_vpc_2.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 443
  to_port        = 443
  ip_protocol    = "tcp"

  tags = {
    Name = "Allow HTTPS In"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_80_vpc_2_pri" {
  security_group_id = aws_security_group.pri_sg_vpc_2.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 80
  to_port        = 80
  ip_protocol    = "tcp"

  tags = {
    Name = "Allow HTTP In"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_53_vpc_2_pri" {
  security_group_id = aws_security_group.pri_sg_vpc_2.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 53
  to_port        = 53
  ip_protocol    = "udp"

  tags = {
    Name = "Allow UDP In"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_out_51820_vpc_2_pri" {
  security_group_id = aws_security_group.pri_sg_vpc_2.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 51820
  to_port        = 51820
  ip_protocol    = "udp"

  tags = {
    Name = "Allow udp out of 51820"
  }
}

####################################################################
#                       Security Groups VPC_3                            
####################################################################

#################### Public Security Group #########################
resource "aws_security_group" "pub_sg_vpc_3" {
  name   = "pub_sg_vpc_3"
  vpc_id = aws_vpc.vpc_3.id
}


resource "aws_vpc_security_group_ingress_rule" "allow_in_vpn_vpc_3" {
  security_group_id = aws_security_group.pub_sg_vpc_3.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 51820
  to_port        = 51820
  ip_protocol    = "udp"

  tags = {
    Name = "Allow Custom UDP"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_443_vpc_3" {
  security_group_id = aws_security_group.pub_sg_vpc_3.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 443
  to_port        = 443
  ip_protocol    = "tcp"

  tags = {
    Name = "Allow HTTPS In"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_80_vpc_3" {
  security_group_id = aws_security_group.pub_sg_vpc_3.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 80
  to_port        = 80
  ip_protocol    = "tcp"

  tags = {
    Name = "Allow HTTP In"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_53_vpc_3" {
  security_group_id = aws_security_group.pub_sg_vpc_3.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 53
  to_port        = 53
  ip_protocol    = "udp"

  tags = {
    Name = "Allow UDP In"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_out_51820_vpc_3" {
  security_group_id = aws_security_group.pub_sg_vpc_3.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 51820
  to_port        = 51820
  ip_protocol    = "udp"

  tags = {
    Name = "Allow udp out of 51820"
  }
}



#################### Private Security Group #########################
resource "aws_security_group" "pri_sg_vpc_3" {
  name   = "TeamSpeak_sg"
  vpc_id = aws_vpc.vpc_3.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_ssh_vpc_3" {
  security_group_id = aws_security_group.pub_sg_vpc_3.id

  cidr_ipv4   = var.internet_access
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  tags = {
    Name = "Allow UDP In"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_pri_vpc_3_30033" {
  security_group_id = aws_security_group.pri_sg_vpc_3.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 30033
  to_port        = 30033
  ip_protocol    = "tcp"

  tags = {
    Name = "Teamspeak Filetransfer"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allow_in_pri_vpc_3_10011_ipv4" {
  security_group_id = aws_security_group.pri_sg_vpc_3.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 10011
  to_port        = 10011
  ip_protocol    = "tcp"

  tags = {
    Name = "Teamspeak Server Query"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_pri_vpc_3_9987_ipv4" {
  security_group_id = aws_security_group.pri_sg_vpc_3.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 9987
  to_port        = 9987
  ip_protocol    = "tcp"

  tags = {
    Name = "Teamspeak Voice"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in_pri_vpc_3_41144_ipv4" {
  security_group_id = aws_security_group.pri_sg_vpc_3.id

  prefix_list_id = aws_ec2_managed_prefix_list.private_ips.id
  from_port      = 41144
  to_port        = 41144
  ip_protocol    = "tcp"

  tags = {
    Name = "Teamspeak TDNS"
  }
}
