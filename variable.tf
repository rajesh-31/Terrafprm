provider "aws" {
  region = "us-east-1"
}
variable "subnet_ids" {
  type = list(string)
  default = ["subnet-0aac4bfb7e1a21c4d","subnet-067c0d06b087c2e39"] # Idea of this part I got from here, i.e , adding subnet ids from console 
}

resource "aws_instance" "EC2" {
  count = length(var.subnet_ids)

  ami = "ami-0cd59ecaf368e5ccf"
  instance_type = "t2.micro"
  subnet_id = var.subnet_ids[count.index]

  tags = {
    Name = "EC2 -${count.index + 1}"
  }
}
