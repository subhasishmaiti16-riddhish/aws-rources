data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_subnet" "main" {
  filter {
    name   = "tag:Name"
    values = ["dev-subnet1"]
  }
}

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["dev-vpc"]
  }
}

data "aws_security_group" "main" {
  for_each = var.ec2
  name     = each.value.sg_name
  vpc_id   = data.aws_vpc.main.id
}
