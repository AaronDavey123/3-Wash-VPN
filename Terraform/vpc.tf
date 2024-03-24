
####################################################################
#                          Creating VPC's                                                  
####################################################################

# Creating vpc_1
resource "aws_vpc" "vpc_1" {
  cidr_block           = var.cidr_block_vpc_1
  enable_dns_hostnames = true


  tags = {
    Name = "${var.project_name}vpc_1"
  }
}

#Creating vpc_2
resource "aws_vpc" "vpc_2" {
  cidr_block           = var.cidr_block_vpc_2
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}vpc_2"
  }
}

# Creating vpc_3
resource "aws_vpc" "vpc_3" {
  cidr_block           = var.cidr_block_vpc_3
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}vpc_3"
  }
}

####################################################################
#       Creating Public & Private Subnet                                 
####################################################################
#########Creating Public & Private Subnet for vpc_1#################

resource "aws_subnet" "pub_subnet_vpc_1" {
  vpc_id                  = aws_vpc.vpc_1.id
  availability_zone       = var.availability_zone[0]
  cidr_block              = var.cidr_pub_subnet_vpc_1
  map_public_ip_on_launch = true


  tags = {
    Name = "${var.project_name}pub_subnet_vpc_1"
  }
}
resource "aws_subnet" "pri_subnet_vpc_1" {
  vpc_id                  = aws_vpc.vpc_1.id
  availability_zone       = var.availability_zone[0]
  cidr_block              = var.cidr_pri_subnet_vpc_1
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}pri_subnet_vpc_1"
  }
}

####################################################################
#########Creating Public & Private Subnet for vpc_2#################

resource "aws_subnet" "pub_subnet_vpc_2" {
  vpc_id                  = aws_vpc.vpc_2.id
  availability_zone       = var.availability_zone[1]
  cidr_block              = var.cidr_pub_subnet_vpc_2
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}pub_subnet_vpc_2"
  }
}

resource "aws_subnet" "pri_subnet_vpc_2" {
  vpc_id                  = aws_vpc.vpc_2.id
  availability_zone       = var.availability_zone[1]
  cidr_block              = var.cidr_pri_subnet_vpc_2
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}pri_subnet_vpc_2"
  }
}

# ####################################################################
# #########Creating Public & Private Subnet for vpc_3#################

resource "aws_subnet" "pub_subnet_vpc_3" {
  vpc_id                  = aws_vpc.vpc_3.id
  availability_zone       = var.availability_zone[2]
  cidr_block              = var.cidr_pub_subnet_vpc_3
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}pub_subnet_vpc_3"
  }
}

resource "aws_subnet" "pri_subnet_vpc_3" {
  vpc_id                  = aws_vpc.vpc_3.id
  availability_zone       = var.availability_zone[2]
  cidr_block              = var.cidr_pri_subnet_vpc_3
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}pri_subnet_vpc_3"
  }
}

####################################################################

####################################################################
#                     VPC Peering vpc-1 -> vpc_2                                                  
####################################################################

resource "aws_vpc_peering_connection" "peer-vpc1-vpc2" {
  peer_owner_id = "376376474359"
  peer_vpc_id   = aws_vpc.vpc_2.id
  vpc_id        = aws_vpc.vpc_1.id
  peer_region   = var.region
  auto_accept   = false

  tags = {
    name = "vpc1 peering vpc2"
  }
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-vpc1-vpc2.id
  auto_accept               = true

  tags = {
    Name = "Accepter"
  }
}

####################################################################
#                     VPC Peering vpc_2 -> vpc_3                                               
####################################################################

resource "aws_vpc_peering_connection" "peer-vpc2-vpc3" {
  peer_owner_id = "376376474359"
  peer_vpc_id   = aws_vpc.vpc_3.id
  vpc_id        = aws_vpc.vpc_2.id
  peer_region   = var.region
  auto_accept   = false

  tags = {
    Name = "vpc2 peering vpc3"
  }
}

resource "aws_vpc_peering_connection_accepter" "peer_1" {
  provider                  = aws
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-vpc2-vpc3.id
  auto_accept               = true

  tags = {
    Name = "Accepter"
  }
}