data "aws_vpc" "this" {
  id = var.aws_vpc_id
}

data "aws_route_table" "this" {
  vpc_id = var.aws_vpc_id
}

data "aws_customer_gateway" "this" {
  id = aws_customer_gateway.this.id
  depends_on = [ aws_customer_gateway.this ]
}

resource "aws_customer_gateway" "this" {
  bgp_asn    = 65000
  ip_address = data.google_compute_address.this.address
  type       = "ipsec.1"
  
  tags = {
    Name = var.name
  }

  depends_on = [ google_compute_address.this ]
}

resource "aws_vpn_gateway" "this" {
  vpc_id = data.aws_vpc.this.id

  tags = {
    Name = var.name
  }
}

resource "aws_vpn_gateway_route_propagation" "this" {
  vpn_gateway_id = aws_vpn_gateway.this.id
  route_table_id = data.aws_route_table.this.route_table_id
}

resource "aws_vpn_connection" "this" {
  vpn_gateway_id       = aws_vpn_gateway.this.id
  customer_gateway_id  = aws_customer_gateway.this.id
  type                 = aws_customer_gateway.this.type
  static_routes_only   = true
  tunnel1_ike_versions = [ "ikev1" ]

  tags = {
    Name = var.name
  }  
}

resource "aws_vpn_connection_route" "this" {
  vpn_connection_id      = aws_vpn_connection.this.id
  destination_cidr_block = data.google_compute_subnetwork.cidr.ip_cidr_range
}

resource "aws_security_group" "this" {
  name        = var.name
  description = "${var.name} allow all traffic"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [ data.google_compute_subnetwork.cidr.ip_cidr_range ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.name
  }
}
