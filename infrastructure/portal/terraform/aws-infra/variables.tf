variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-2"
}

# ubuntu-trusty-16.04 (x64)
variable "aws_amis" {
  default = {
    "us-east-2" = "ami-65f2d700"
  }
}

variable "availability_zones" {
  default     = "us-east-2b,us-east-2c,us-east-2a"
  description = "List of availability zones, use AWS CLI to find your "
}

variable "key_name" {
  default     = "Laravel Autoscale group key"
  description = "Name of AWS key pair"
}

variable "instance_type" {
  default     = "m4.large"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "2"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "2"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "2"
}
