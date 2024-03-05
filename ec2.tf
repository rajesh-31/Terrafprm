provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}

# Define an AWS key pair for SSH access
resource "aws_key_pair" "example_key_pair" {
  key_name   = "my-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with the path to your public key
}

 resource "aws_security_group" "example_security_group" {
  name        = "my-security-group"
  description = "Example security group with dynamic ingress rules"
  vpc_id      = "ami-07d9b9ddc6cd8dd30" # Replace with your VPC ID

   dynamic "ingress" {
    for_each = [22, 88, 3306, 443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from any IP address (adjust as needed)
    }
  }
}

resource "aws_instance" "app_server" {
  ami            = "ami-03f4878755434977f"
  instance_type  = "t2.micro"
  key_name       = "${aws_key_pair.example_key_pair.key_name}"  # Associate the key pair with the instance
  vpc_security_group_ids = ["${aws_security_group.example_security_group.id}"]
  
  tags = {
    Name = "MyTerraformInstance"
  }
   user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y          # Update the package repository (for ubuntu)
              sudo apt-get install -y openjdk-17-jdk  # Install Java
              sudo apt-get install -y python3    # Install Python3
              curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null
             echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null 
              sudo apt-get update
              sudo apt-get install -y jenkins   # Install Jenkins
              sudo systemctl start jenkins  # Start Jenkins
              sudo systemctl enable jenkins   # Enable Jenkins to start on boot
              EOF
}
