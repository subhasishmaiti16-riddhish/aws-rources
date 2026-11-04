resource "tls_private_key" "ssh" {
  for_each = var.ec2
  algorithm = each.value.key_algorithm
  rsa_bits  = each.value.key_rsa_bits
}

resource "aws_key_pair" "terraform" {
  for_each   = var.ec2
  key_name   = each.value.key_name
  public_key = tls_private_key.ssh[each.key].public_key_openssh
}



resource "aws_instance" "ec2" {
  for_each                    = var.ec2
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = each.value.instance_type
  subnet_id                   = data.aws_subnet.main.id
  key_name                    = aws_key_pair.terraform[each.key].key_name
  vpc_security_group_ids      = [data.aws_security_group.main[each.key].id]
  associate_public_ip_address = true

  tags = {
    Name = each.value.ec2_name
  }
}

