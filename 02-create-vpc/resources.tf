resource "aws_vpc" "VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags {
    Name = "STUDENT"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = "${aws_vpc.VPC.id}"
  tags {
    Name = "STUDENT-IGW"
  }
}

resource "aws_subnet" "PubSubnetAza" {
  vpc_id     = "${aws_vpc.VPC.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  tags {
    Name = "PubSubnetAza"
  }
}

resource "aws_route_table" "AZaRoute" {
  vpc_id = "${aws_vpc.VPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IGW.id}"
  }
  tags {
    Name = "AZaRoute"
  }
}

resource "aws_route_table_association" "PubAZaRouteAssoc" {
  subnet_id      = "${aws_subnet.PubSubnetAza.id}"
  route_table_id = "${aws_route_table.AZaRoute.id}"
}

resource "aws_security_group" "SGALL" {
  name        = "DevOps"
  description = "Allow all inbound traffic"
  vpc_id = "${aws_vpc.VPC.id}"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "DevOps"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0b1e356e"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.PubSubnetAza.id}"
  key_name = "devops"
  vpc_security_group_ids = ["${aws_security_group.SGALL.id}"]

  tags {
    Name = "WEB"
  }
}