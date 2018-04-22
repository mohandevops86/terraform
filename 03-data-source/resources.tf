data "aws_ami" "redhat" {
  most_recent = true
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
filter {
    name   = "state"
    values = ["available"]
  }
  owners = ["${var.owner}"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.redhat.id}"
  instance_type = "t2.micro"
  subnet_id = "subnet-dcf4e1b5"
  key_name = "devops"
  vpc_security_group_ids = ["sg-b10a9ed9"]

  tags {
    Name = "WEB"
  }
}