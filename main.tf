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

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "MyTerraformInstance"
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_name
  tags = {
    Name = "MyS3Bucket"
  }
}

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

