vpc-dev = {
  dev-vpc = {
    cidr_block = "10.0.0.0/16"
  }
}
subnet-dev = {
  dev-subnet1 = {
    vpc_id            = "dev-vpc"
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"

  }
  dev-subnet2 = {
    vpc_id            = "dev-vpc"
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1b"
  }
}
sg-dev = {
  sg-dev1 = {
    sg_name = "terraform-ssh-sg"
  }
}
ec2-dev = {
  ec2-dev1 = {
    sg_name       = "terraform-ssh-sg"
    instance_type = "t3.micro"
    key_name      = "terraform-key"
    ec2_name      = "new_ec2"
  }
}