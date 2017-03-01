variable "image" {
  default = ""
}

variable "flavor" {
  default = "m1.medium"
}

variable "ssh_key_file" {
  default = ""
}

variable "ssh_user_name" {
  default = "centos"
}

variable "external_gateway" {}

variable "pool" {
  default = "public"
}
