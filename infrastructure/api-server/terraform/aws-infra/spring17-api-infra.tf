# Use the state information from aws s3
/*data "terraform_remote_state" "foo" {
    backend = "s3"
    config {
        bucket = "spring17-api-terraform-state"
        key = "api-server/terraform.tfstate"
        region = "us-east-2"
    }
}*/

# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

# Creating AWS Autosclaing group for API-server
resource "aws_autoscaling_group" "web-asg" {
  availability_zones   = ["${split(",", var.availability_zones)}"]
  name                 = "spring17-api-terraform-asg"
  max_size             = "${var.asg_max}"
  min_size             = "${var.asg_min}"
  desired_capacity     = "${var.asg_desired}"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.web-lc.name}"

  # Needed, to enable modification to launch config post creation
  lifecycle {
      create_before_destroy = true
    }

  #vpc_zone_identifier = ["${split(",", var.availability_zones)}"]
  tag {
    key                 = "Name"
    value               = "spring17-api-terraform-asg-instances"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "web-lc" {
  name_prefix          = "spring17-api-terraform-lc-"
  image_id             = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type        = "${var.instance_type}"
  spot_price           = "0.02"
  iam_instance_profile = "spring17-api-gateway-EC2CodeDeployRole"

  # Needed, to enable modification to launch config post creation
  lifecycle {
      create_before_destroy = true
    }

  # Security group
  security_groups = ["${aws_security_group.default.id}"]
  user_data       = "${file("userdata.sh")}"
  key_name        = "${var.key_name}"
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name        = "spring17-api-terraform-sg"
  description = "Used in the terraform"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # API access from anywhere FixME: Add all the ports that are necessary
  ingress {
    from_port   = 0
    to_port     = 8600
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 9190
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
