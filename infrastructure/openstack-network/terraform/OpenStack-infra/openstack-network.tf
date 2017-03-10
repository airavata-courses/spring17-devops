provider "openstack" {
    user_name  = ""
    tenant_name = ""
    password  = ""
    auth_url  = ""
}

resource "openstack_networking_network_v2" "terraform" {
  name           = "airavata-courses-server-network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "terraform" {
  name            = "airavata-courses-server-subnet"
  network_id      = "${openstack_networking_network_v2.terraform.id}"
  cidr            = "10.1.0.0/22"
  ip_version      = 4
}

resource "openstack_networking_router_v2" "terraform" {
  name             = "airavata-courses-network-router"
  admin_state_up   = "true"
  external_gateway = "${var.external_gateway}"
}

resource "openstack_networking_router_interface_v2" "terraform" {
  router_id = "${openstack_networking_router_v2.terraform.id}"
  subnet_id = "${openstack_networking_subnet_v2.terraform.id}"
}
