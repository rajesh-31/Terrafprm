provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}

resource "aws_db_subnet_group" "custom_subnet_group" {
  name        = "custom-subnet-group"
  description = "Custom DB subnet group"
  subnet_ids  = ["subnet-003077a556a405c56", "subnet-098fdd300ccdd747d"]  # Specify your subnet IDs
}

resource "aws_db_instance" "myrds" {
   allocated_storage   = 20
   storage_type        = "gp2"
   identifier          = "rdstf"
   engine              = "mysql"
   engine_version      = "8.0.35"
   instance_class      = "db.t3.micro"
   username            = "admin"
   password            = "Passw0rd!123"
   publicly_accessible = true
   skip_final_snapshot = true
   db_subnet_group_name = aws_db_subnet_group.custom_subnet_group.name

   tags = {
     Name = "MyRDS"
   }
 }
