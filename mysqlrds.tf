provider "aws" {
  region = "us-east-1"  # Modify this to your desired AWS region
}

resource "aws_db_subnet_group" "example" {
  name       = "example-subnet-group"
  subnet_ids = ["subnet-12345678", "subnet-87654321"]  # Modify these with your actual subnet IDs
  tags = {
    Name = "example-subnet-group"
  }
}

resource "aws_db_instance" "example" {
  identifier            = "example-mysql-db"
  allocated_storage     = 20  # Specify storage size in GB
  engine                = "mysql"
  engine_version        = "8.0"  # You can change the version if needed
  instance_class        = "db.t2.micro"  # Choose an appropriate instance class
  username              = "admin"
  password              = "password"  # Replace with your desired password
  db_subnet_group_name  = aws_db_subnet_group.example.name
  publicly_accessible   = false
  skip_final_snapshot   = true

  tags = {
    Name = "example-mysql-db"
  }
}

output "db_endpoint" {
  value = aws_db_instance.example.endpoint
}
