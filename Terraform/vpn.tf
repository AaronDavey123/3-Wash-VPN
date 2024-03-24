# ####################################################################
# #                       Transit Gateway                 
# ####################################################################
# resource "aws_ec2_transit_gateway" "tranist_gw" {
#   amazon_side_asn             = "64512"
#   description                 = "Transit Gateway for VPCs VPN connection"
#   transit_gateway_cidr_blocks = ["172.16.4.0/24", "17.15.5.0/24"]
# }

# resource "ws_ec2_transit_gateway_route_table_association" "asc_transit_rt" {
#   provider = aws.us-east-1



# }

# resource "aws_ec2_transit_gateway_route_table" "transit_rt" {
#   transit_gateway_id = aws_ec2_transit_gateway.tranist_gw.id

# }



# ####################################################################
# #                       Customer Gateway                 
# ####################################################################
# resource "aws_customer_gateway" "wg0" {
#   bgp_asn    = 65000
#   ip_address = "172.16.4.1"
#   type       = "ipsec.1"
# }




# ####################################################################
# #                       VPN Connections                
# ####################################################################
# resource "aws_vpn_gateway" "vpn_gw" {
#   vpc_id = aws_vpc.vpc_2.id
# }

# resource "aws_vpn_gateway_route_propagation" "main" {
#   vpn_gateway_id = aws_vpn_gateway.vpn_gw.id
#   route_table_id = aws_route_table.private_route_table_vpc_2.id
# }


# resource "aws_vpn_connection" "vpn" {
#   vpn_gateway_id      = aws_vpn_gateway.vpn_gw.id
#   customer_gateway_id = aws_customer_gateway.wg0.id
#   type                = "ipsec.1"
#   static_routes_only  = true
# }



# ####################################################################
# #                    Direct Conenction Gateway                
# ####################################################################
# resource "aws_dx_gateway" "dx_gw" {
#   name            = "ipsec_vpn"
#   amazon_side_asn = "64512"
# }

# data "aws_ec2_transit_gateway_dx_gateway_attachment" "transit_gw_atc" {
#   dx_gateway_id = aws_dx_gateway.dx_gw.id

#   depends_on = [aws_dx_gateway_association.dx_gw_asc]
# }

# resource "aws_dx_gateway_association" "dx_gw_asc" {
#   dx_gateway_id         = aws_dx_gateway.dx_gw.id
#   associated_gateway_id = aws_ec2_transit_gateway.tranist_gw.id
#   allowed_prefixes = [
#     "172.16.4.0/24",
#     "17.15.5.0/24"
#   ]
# }