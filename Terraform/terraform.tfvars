region       = "us-east-1"
project_name = "AWS Wash-"
ec2_type     = "t2.micro"


internet_access      = "0.0.0.0/0"
internet_access_ipv6 = "::/0"

ami     = "ami-0fc5d935ebf8bc3bc"
ami-vpn = "ami-0f95ee6f985388d58"


availability_zone = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c"
]

cidr_block_vpc_1      = "10.1.0.0/16"
cidr_pub_subnet_vpc_1 = "10.1.1.0/24"
cidr_pri_subnet_vpc_1 = "10.1.2.0/24"


cidr_block_vpc_2      = "10.2.0.0/16"
cidr_pub_subnet_vpc_2 = "10.2.1.0/24"
cidr_pri_subnet_vpc_2 = "10.2.2.0/24"

cidr_block_vpc_3      = "10.3.0.0/16"
cidr_pub_subnet_vpc_3 = "10.3.1.0/24"
cidr_pri_subnet_vpc_3 = "10.3.2.0/24"

# eip_openvpn          = "10.1.1.189"
# eip_peerA            = "10.2.1.0/24"
# eip_peerB            = "44.218.172.0/24"
# eip_TeamSpeak        = "10.3.1.168"
# eip_wireguard        = "44.198.66.0/24"
