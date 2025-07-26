terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.12.2"
}

provider "aws" {
  region = var.aws_region
}

#  Security Group that allows HTTP (port 80) and SSH (port 22)
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"
#  vpc_id      = var.vpc_id  # make sure to define this in variables.tf

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebServerSG"
  }
}

#  EC2 instance with security group
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type

  user_data              = file("${path.module}/user_data.sh")
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "MyTerraformInstance"
  }
}

#  S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_name
  tags = {
    Name = "MyS3Bucket"
  }
}

#  DynamoDB Table
resource "aws_dynamodb_table" "my_table" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "MyDynamoDBTable"
  }
}


