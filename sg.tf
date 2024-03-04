  # creating a sequrity group
  resource "aws_security_group" "example_security_group" {
  name        = "example-security-group"
  description = "Example security group with dynamic ingress rules"
  vpc_id      = "vpc-0dfbf472a2d5102d3" # Replace with your VPC ID

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
