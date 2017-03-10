provider "openstack" {
    user_name  = ""
    tenant_name = ""
    password  = ""
    auth_url  = ""
}

resource "openstack_compute_keypair_v2" "terraform" {
  name       = "anuj-desktop-keypair"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}


resource "openstack_compute_secgroup_v2" "terraform" {
  name        = "jenkins-server-security-group"
  description = "Security group for the jenkins server instances"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 8080
    to_port     = 8080
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_floatingip_v2" "terraform" {
  pool       = "${var.pool}"
}

resource "openstack_compute_instance_v2" "terraform" {
  name            = "jenkins-server-compute-instance"
  image_id      = "${var.image}"
  flavor_name     = "${var.flavor}"
  key_pair        = "${openstack_compute_keypair_v2.terraform.name}"
  security_groups = ["${openstack_compute_secgroup_v2.terraform.name}"]
  floating_ip     = "${openstack_compute_floatingip_v2.terraform.address}"
  user_data       = "${file("userdata.sh")}"

  network {
    name = "airavata-courses-server-network"
  }
}
