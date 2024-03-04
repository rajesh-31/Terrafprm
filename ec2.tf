terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# Define an AWS key pair for SSH access
resource "aws_key_pair" "example_key_pair" {
  key_name   = "example-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with the path to your public key
}

resource "aws_instance" "app_server" {
  ami            = "ami-03f4878755434977f"
  instance_type  = "t2.micro"
  key_name       = "${aws_key_pair.example_key_pair.key_name}"  # Associate the key pair with the instance
  vpc_security_group_ids = "${security_group.example_security_group.id}"
  
  tags = {
    Name = "ExampleInstance"
  }
}
