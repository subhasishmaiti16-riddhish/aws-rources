resource "aws_instance" "example" {
  for_each = var.ec2
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = each.value.instance_type
  subnet_id                   = data.aws_subnet.main.id
  key_name                    = each.value.key_name
  vpc_security_group_ids      = [data.aws_security_group.main[each.key].id]
  associate_public_ip_address = true

  tags = {
    Name = each.value.ec2_name
  }
}