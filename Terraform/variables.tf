####################################################################
####################################################################
variable "region" { type = string }
variable "project_name" { type = string }
variable "internet_access" { type = string }
variable "internet_access_ipv6" { type = string }
variable "ec2_type" { type = string }
variable "ami" { type = string }
variable "ami-vpn" { type = string }
variable "availability_zone" { type = list(string) }
####################################################################
####################################################################

variable "cidr_block_vpc_1" { type = string }
variable "cidr_pub_subnet_vpc_1" { type = string }
variable "cidr_pri_subnet_vpc_1" { type = string }

####################################################################

variable "cidr_block_vpc_2" { type = string }
variable "cidr_pub_subnet_vpc_2" { type = string }
variable "cidr_pri_subnet_vpc_2" { type = string }

####################################################################
variable "cidr_block_vpc_3" { type = string }
variable "cidr_pub_subnet_vpc_3" { type = string }
variable "cidr_pri_subnet_vpc_3" { type = string }

####################################################################
####################################################################

# variable "eip_for_nat_gw_vpc_1" { type = string}
# variable "eip_openvpn" { type = string }
# variable "eip_peerA" { type = string }
# variable "eip_peerB" { type = string }
# variable "eip_TeamSpeak" { type = string }
# variable "eip_wireguard" { type = string }



