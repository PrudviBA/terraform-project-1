
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ami_id" {
  type    = string
  default = "ami-020cba7c55df1f615" # Amazon Linux 2 AMI (for us-east-1)
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "s3_bucket_name" {
  type    = string
  default = "my-terraform-state-bucket-prudvi123" # Make sure this is globally unique
}

variable "dynamodb_table_name" {
  type    = string
  default = "my-terraform-lock-table-prudvi"
}

