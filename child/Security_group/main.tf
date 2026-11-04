resource "aws_security_group" "ssh" {
  for_each = var.sg
  name     = each.value.sg_name
  vpc_id   = data.aws_vpc.main.id

  ingress {      #####Inbound traffic rules
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["106.202.36.233/32"]    #### My computer's public IP address
  }

  egress {    #####Outbound traffic rules
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
