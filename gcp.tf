data "google_compute_address" "this" {
  name = var.name

 depends_on = [ google_compute_address.this ]
}

 data "google_compute_network" "network" {
   name = var.gcp_network
 }

data "google_compute_subnetwork" "cidr" {
  name = var.gcp_subnet
}

resource "google_compute_address" "this" {
  name = var.name
}
 
resource "google_compute_vpn_gateway" "this" {
   name    = var.name
   network = data.google_compute_network.network.id
 }

resource "google_compute_vpn_tunnel" "tunnel1" {
  name                    = "${var.name}-tunnel1"
  peer_ip                 = aws_vpn_connection.this.tunnel1_address
  shared_secret           = aws_vpn_connection.this.tunnel1_preshared_key
  target_vpn_gateway      = google_compute_vpn_gateway.this.id
  ike_version             = 1
  local_traffic_selector  = [ "0.0.0.0/0" ]
  remote_traffic_selector = [ "0.0.0.0/0" ]
  
  depends_on = [
   google_compute_forwarding_rule.esp,
   google_compute_forwarding_rule.udp500,
   google_compute_forwarding_rule.udp4500,
   google_compute_vpn_gateway.this,
 ]
}

resource "google_compute_vpn_tunnel" "tunnel2" {
  name                    = "${var.name}-tunnel2"
  peer_ip                 = aws_vpn_connection.this.tunnel2_address
  shared_secret           = aws_vpn_connection.this.tunnel2_preshared_key
  target_vpn_gateway      = google_compute_vpn_gateway.this.id
  ike_version             = 1
  local_traffic_selector  = [ "0.0.0.0/0" ]
  remote_traffic_selector = [ "0.0.0.0/0" ]
  
  depends_on = [
   google_compute_forwarding_rule.esp,
   google_compute_forwarding_rule.udp500,
   google_compute_forwarding_rule.udp4500,
   google_compute_vpn_gateway.this,
 ]
}
 
resource "google_compute_forwarding_rule" "esp" {
  name        = "${var.name}-esp"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.this.address
  target      = google_compute_vpn_gateway.this.id
}

resource "google_compute_forwarding_rule" "udp500" {
  name        = "${var.name}-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.this.address
  target      = google_compute_vpn_gateway.this.id
}

resource "google_compute_forwarding_rule" "udp4500" {
  name        = "${var.name}-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.this.address
  target      = google_compute_vpn_gateway.this.id
}

 resource "google_compute_route" "this" {
   name       = "${var.name}-route"
   network    = data.google_compute_network.network.name
   dest_range = data.aws_vpc.this.cidr_block
   priority   = 1000
 
   next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel1.id
}

resource "google_compute_firewall" "this" {
  name    = "${var.name}"
  network = data.google_compute_network.network.name

  allow {
    protocol = "all"
  }
  
  priority = 1000
  source_ranges = [ data.aws_vpc.this.cidr_block ]
}
