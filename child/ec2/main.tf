resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = data.aws_subnet.main.id

  tags = {
    Name = "HelloWorld"
  }
}
