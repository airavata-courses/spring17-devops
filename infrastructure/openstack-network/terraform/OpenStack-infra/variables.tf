variable "image" {
  default = "1790e5c8-315a-4b9b-8b1f-46e47330d3cc"
}

variable "flavor" {
  default = "m1.medium"
}

variable "ssh_key_file" {
  default = "~/.ssh/id_rsa"
}

variable "ssh_user_name" {
  default = "centos"
}

variable "external_gateway" {}

variable "pool" {
  default = "public"
}
