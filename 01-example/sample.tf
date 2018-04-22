provider "aws" {
  #access_key = "" ## export AWS_ACCESS_KEY_ID="anaccesskey"1
  #secret_key = "" ## export AWS_SECRET_ACCESS_KEY="asecretkey"
  ## Export ACCESS and SECRET Key from CLI
  region     = "us-east-2"
}

resource "aws_security_group" "allow_all" {
  name        = "DevOps"
  description = "Allow all inbound traffic"

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