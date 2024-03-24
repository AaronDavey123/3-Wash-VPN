####################################################################
#                      Create Network Interface                                
####################################################################
################### Network Interface VPC 1 #########################
resource "aws_network_interface" "nif_vpc_1_pri" {
  subnet_id       = aws_subnet.pri_subnet_vpc_1.id
  private_ip      = "10.1.2.50"
  security_groups = [aws_security_group.pri_sg.id]
}

################### Network Interface VPC 2 #########################
resource "aws_network_interface" "nif_vpc_2_pri" {
  subnet_id       = aws_subnet.pri_subnet_vpc_2.id
  private_ip      = "10.2.2.50"
  security_groups = [aws_security_group.pri_sg_vpc_2.id]
}

################### Network Interface VPC 3 #########################

resource "aws_network_interface" "nif_vpc_3_pri" {
  subnet_id       = aws_subnet.pri_subnet_vpc_3.id
  private_ip      = "10.3.2.50"
  security_groups = [aws_security_group.pri_sg_vpc_3.id]
}


####################################################################
#       Creating Internet Gateways || Attaching Internet Gateways                                  
####################################################################
################### Interent Gateway VPC 1 #########################
resource "aws_internet_gateway" "igw_vpc_1" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    Name = "${var.project_name}igw_vpc_1"
  }
}

################### Interent Gateway VPC 2 #########################

resource "aws_internet_gateway" "igw_vpc_2" {
  vpc_id = aws_vpc.vpc_2.id

  tags = {
    Name = "${var.project_name}igw_vpc_2"
  }
}

################### Interent Gateway VPC 3 #########################
resource "aws_internet_gateway" "igw_vpc_3" {
  vpc_id = aws_vpc.vpc_3.id

  tags = {
    Name = "${var.project_name}igw_vpc_3"
  }
}

####################################################################
#                   Creating NAT Gateways                                  
####################################################################
##################### NAT Gateway VPC 1  ###########################

resource "aws_nat_gateway" "nat_gw_vpc_1" {
  subnet_id         = aws_subnet.pub_subnet_vpc_1.id
  allocation_id     = aws_eip.eip_for_nat_gw.id
  connectivity_type = "public"

  tags = {
    Name = "${var.project_name}nat_gateway_private_vpc_1"
  }
}

####################################################################
#                   Creating Elastic IP                                 
####################################################################
################### Creatomg Elastic IP VPC 1  #####################

resource "aws_eip" "eip_for_nat_gw" {
  depends_on = [aws_internet_gateway.igw_vpc_1]
  domain     = "vpc"

  tags = {
    Name = "EIP for NAT_VPC_1"
  }
}

################### Creatomg Elastic IP VPC 2  #####################

resource "aws_eip" "eip_for_vpc_2_pri" {
  depends_on = [aws_internet_gateway.igw_vpc_2]
  domain     = "vpc"

  tags = {
    Name = "EIP for Wireguard"
  }
}

resource "aws_eip_association" "eip_vpc_2_pri" {
  instance_id   = aws_instance.pri_subnet_vpc_2.id
  allocation_id = aws_eip.eip_for_vpc_2_pri.id
}

resource "aws_eip" "eip_for_vpc_2_pub" {
  depends_on = [aws_internet_gateway.igw_vpc_2]
  domain     = "vpc"

  tags = {
    Name = "EIP for Peer A"
  }
}

resource "aws_eip_association" "eip_vpc_2_pub" {
  instance_id   = aws_instance.pub_subnet_vpc_2.id
  allocation_id = aws_eip.eip_for_vpc_2_pub.id
}

################### Creating Elastic IP VPC 3  #####################
resource "aws_eip" "eip_for_vpc_3_pub" {
  depends_on = [aws_internet_gateway.igw_vpc_3]
  domain     = "vpc"

  tags = {
    Name = "EIP for Peer B"
  }
}

resource "aws_eip_association" "eip_vpc_3_pub" {
  instance_id   = aws_instance.pub_subnet_vpc_3.id
  allocation_id = aws_eip.eip_for_vpc_3_pub.id
}

resource "aws_eip" "eip_for_vpc_3_pri" {
  depends_on = [aws_internet_gateway.igw_vpc_3]
  domain     = "vpc"

  tags = {
    Name = "EIP for VOiP"
  }
}

resource "aws_eip_association" "eip_vpc_3_pri" {
  instance_id   = aws_instance.pri_subnet_vpc_3.id
  allocation_id = aws_eip.eip_for_vpc_3_pri.id
}



####################################################################
#                  Private & Public Route Table                  
####################################################################
#################### public route table vpc 1 ######################
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    Name = "${var.project_name}public_route_table"
  }
}

resource "aws_route" "internet_access_public_subnet" {
  route_table_id = aws_route_table.public_route_table.id

  destination_cidr_block = var.internet_access
  gateway_id             = aws_internet_gateway.igw_vpc_1.id

}

resource "aws_route_table_association" "asc_public_route_table" {
  subnet_id      = aws_subnet.pub_subnet_vpc_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route" "route_pub_traffic_to_vpc_1_pri" {
  route_table_id = aws_route_table.public_route_table.id

  destination_cidr_block = var.cidr_pri_subnet_vpc_1
  nat_gateway_id         = aws_nat_gateway.nat_gw_vpc_1.id
  
}

################## private route table vpc 1 ######################
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    Name = "${var.project_name}private_route_table"
  }
}

resource "aws_route" "nat_gw_private_subnet" {
  route_table_id = aws_route_table.private_route_table.id

  destination_cidr_block = var.internet_access
  nat_gateway_id         = aws_nat_gateway.nat_gw_vpc_1.id

}

resource "aws_route_table_association" "asc_private_route_table" {
  subnet_id      = aws_subnet.pri_subnet_vpc_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route" "route_pri_traffic_to_vpc_2" {
  route_table_id = aws_route_table.private_route_table.id

  destination_cidr_block    = var.cidr_pub_subnet_vpc_2
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-vpc1-vpc2.id

}


################### public route table vpc 2 ######################
resource "aws_route_table" "public_route_table_vpc_2" {
  vpc_id = aws_vpc.vpc_2.id

  tags = {
    Name = "${var.project_name}public_route_table_vpc_2"
  }
}

resource "aws_route" "internet_access_public_subnet_vpc_2" {
  route_table_id = aws_route_table.public_route_table_vpc_2.id

  destination_cidr_block = var.internet_access
  gateway_id             = aws_internet_gateway.igw_vpc_2.id

}

resource "aws_route_table_association" "asc_public_route_table_vpc_2" {
  subnet_id      = aws_subnet.pub_subnet_vpc_2.id
  route_table_id = aws_route_table.public_route_table_vpc_2.id
}

resource "aws_route" "route_pub_vpc2_traffic_to_vpc3" {
  route_table_id = aws_route_table.public_route_table_vpc_2.id

  destination_cidr_block = var.cidr_pri_subnet_vpc_2
  network_interface_id   = aws_network_interface.nif_vpc_2_pri.id

}


#################### private route table vpc 2 #######################
resource "aws_route_table" "private_route_table_vpc_2" {
  vpc_id = aws_vpc.vpc_2.id

  tags = {
    Name = "${var.project_name}private_route_table_vpc_2"
  }
}

resource "aws_route" "internet_access_private_subnet_vpc_2" {
  route_table_id = aws_route_table.private_route_table_vpc_2.id

  destination_cidr_block = var.internet_access
  gateway_id             = aws_internet_gateway.igw_vpc_2.id

}

resource "aws_route_table_association" "asc_private_route_table_vpc_2" {
  subnet_id      = aws_subnet.pri_subnet_vpc_2.id
  route_table_id = aws_route_table.private_route_table_vpc_2.id
}

resource "aws_route" "route_pri_vpc2_traffic_to_vpc3" {
  route_table_id = aws_route_table.private_route_table_vpc_2.id

  destination_cidr_block    = var.cidr_pub_subnet_vpc_3
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-vpc2-vpc3.id
}

#################### public route table vpc 3 ########################
resource "aws_route_table" "public_route_table_vpc_3" {
  vpc_id = aws_vpc.vpc_3.id

  tags = {
    Name = "${var.project_name}public_route_table_vpc_3"
  }
}

resource "aws_route" "internet_access_vpc_3_pub" {
  route_table_id = aws_route_table.public_route_table_vpc_3.id

  destination_cidr_block = var.internet_access
  gateway_id             = aws_internet_gateway.igw_vpc_3.id
}

resource "aws_route_table_association" "asc_public_route_table_vpc_3" {
  subnet_id      = aws_subnet.pub_subnet_vpc_3.id
  route_table_id = aws_route_table.public_route_table_vpc_3.id
}

resource "aws_route" "route_pub_vpc_3_to_pri_vpc_3" {
  route_table_id = aws_route_table.public_route_table_vpc_3.id

  destination_cidr_block = var.cidr_pri_subnet_vpc_3
  network_interface_id   = aws_network_interface.nif_vpc_3_pri.id

}

#################### private route table vpc 3 #######################
resource "aws_route_table" "private_route_table_vpc_3" {
  vpc_id = aws_vpc.vpc_3.id

  tags = {
    Name = "${var.project_name}private_route_table_vpc_3"
  }
}

resource "aws_route" "internet_access_vpc_3_pri" {
  route_table_id = aws_route_table.private_route_table_vpc_3.id

  destination_cidr_block = var.internet_access
  gateway_id             = aws_internet_gateway.igw_vpc_3.id
}

resource "aws_route_table_association" "asc_private_route_table_vpc_3" {
  subnet_id      = aws_subnet.pri_subnet_vpc_3.id
  route_table_id = aws_route_table.private_route_table_vpc_3.id
}