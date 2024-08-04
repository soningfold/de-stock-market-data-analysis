resource "aws_security_group" "allow_connection" {
  name        = "allow_connection"
  description = "Allow SSH inbound traffic and all outbound traffic"

  tags = {
    Name = "allows ssh and http connection"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_connection.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  tags = {
    Name = "allows incoming ssh on any ipv4 connection"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_connection.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  tags = {
    Name = "allows all outgoing traffic on ipv4 connections"
  }
}
