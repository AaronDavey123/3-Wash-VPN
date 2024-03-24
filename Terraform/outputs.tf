output "availability_zone_public_subnet_vpc_1" {
  value = aws_subnet.pub_subnet_vpc_1.availability_zone
}

output "availability_zone_private_subnet_vpc_1" {
  value = aws_subnet.pri_subnet_vpc_1.availability_zone
}

output "availability_zone_public_subent_vpc_2" {
  value = aws_subnet.pub_subnet_vpc_2.availability_zone
}

output "availability_zone_private_subnet_vpc_2" {
  value = aws_subnet.pri_subnet_vpc_2.availability_zone
}

output "availability_zone_public_subnet_vpc_3" {
  value = aws_subnet.pub_subnet_vpc_3.availability_zone
}

output "availability_zone_private_subnet_vpc_3" {
  value = aws_subnet.pri_subnet_vpc_3.availability_zone
}
