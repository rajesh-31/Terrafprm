provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "your-unique-bucket-name"  # Replace with a globally unique bucket name

  acl    = "private"  # Access Control List, options: private, public-read, public-read-write, aws-exec-read, authenticated-read
  force_destroy = true  # Set to true to enable deletion of the bucket even if it's not empty

  tags = {
    Name        = "example-bucket"
    Environment = "production"
  }
}
