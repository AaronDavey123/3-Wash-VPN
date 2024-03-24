####################################################################
#                       Network Load Balancer                              
####################################################################

resource "aws_lb" "nlb_public_vpc_1" {
  name                       = "nlb"
  internal                   = true
  load_balancer_type         = "network"
  security_groups            = [aws_security_group.sg_nlb.id]
  enable_deletion_protection = false

  subnet_mapping {
    subnet_id = aws_subnet.pub_subnet_vpc_1.id
  }

  tags = {
    Environment = "NLB"
  }
}

resource "aws_lb_target_group" "nlb_target_group" {

  name     = "targetgroup"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc_1.id
}



resource "aws_lb_listener" "nlb_listner" {
  load_balancer_arn = aws_lb.nlb_public_vpc_1.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
    type             = "forward"

  }

}


####################################################################
#               Network Load Balancer Security Group
####################################################################

resource "aws_security_group" "sg_nlb" {
  name        = "sg_nlb"
  description = "Allow inbound and outbound traffic"
  vpc_id      = aws_vpc.vpc_1.id
}

resource "aws_vpc_security_group_egress_rule" "nlb_allow_all_out" {
  security_group_id = aws_security_group.sg_nlb.id

  cidr_ipv4   = var.internet_access
  ip_protocol = "All"


  tags = {
    Name = "Allow All Traffic out"
  }
}
resource "aws_vpc_security_group_ingress_rule" "nlb_allow_all_in" {
  security_group_id = aws_security_group.sg_nlb.id

  cidr_ipv4   = var.internet_access
  ip_protocol = "All"

  tags = {
    Name = "Allow All Traffic in"
  }

}
