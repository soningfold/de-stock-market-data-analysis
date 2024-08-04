resource "aws_security_group" "allow_connection" {
  name        = "allow_connection"
  description = "Allows all protocols inbound on any port"

  tags = {
    Name = "Allows all protocols inbound on any port"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_inbound_traffic_ipv4" {
  security_group_id = aws_security_group.allow_connection.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol       = -1 #same as specifying all ports and all ips
  tags = {
    Name = "Allows all protocols inbound on any port"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outgoing_traffic_ipv4" {
  security_group_id = aws_security_group.allow_connection.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" #same as specifying all ports and all ips
  tags = {
    Name = "allows all outgoing traffic on ipv4 connections"
  }
}
