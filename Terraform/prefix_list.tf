####################################################################
#                       Prefix_list                          
####################################################################

resource "aws_ec2_managed_prefix_list" "private_ips" {
  name           = "private_ips"
  address_family = "IPv4"
  max_entries    = 9

  entry {
    cidr        = var.cidr_block_vpc_1
    description = "vpc_1"
  }

  entry {
    cidr        = var.cidr_block_vpc_2
    description = "vpc_2"
  }

  entry {
    cidr        = var.cidr_block_vpc_3
    description = "vpc_3"
  }

  entry {
    cidr        = var.cidr_pri_subnet_vpc_1
    description = "pri_subnet_vpc_1"
  }

  entry {
    cidr        = var.cidr_pri_subnet_vpc_2
    description = "pri_subnet_vpc_2"
  }

  entry {
    cidr        = var.cidr_pri_subnet_vpc_3
    description = "pri_subnet_vpc_3"
  }

  entry {
    cidr        = var.cidr_pub_subnet_vpc_1
    description = "pub_subnet_vpc_1"
  }

  entry {
    cidr        = var.cidr_pub_subnet_vpc_2
    description = "pub_subnet_vpc_2"
  }

  entry {
    cidr        = var.cidr_pub_subnet_vpc_3
    description = "pub_subnet_vpc_3"
  }
}

