# Specify the AWS provider and region
provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}

# Define an AWS key pair for SSH access
resource "aws_key_pair" "example_key_pair" {
  key_name   = "example-key-pair"
  public_key = file("~/.ssh/your-public-key.pub")  # Replace with the path to your public key
}

# Define an AWS EC2 instance
resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Specify the desired Amazon Machine Image (AMI)
  instance_type = "t2.micro"                # Specify the instance type

  key_name      = "${aws_key_pair.example_key_pair.key_name}"  # Associate the key pair with the instance

  tags = {
    Name = "example-instance"
  }
