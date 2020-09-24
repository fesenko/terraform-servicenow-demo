# variable.tf

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "aws_az" {
  description = "AWS availability zone"
  default     = "us-east-1d"
}

variable "ami_id" {
  description = "ID of the AMI to provision. Default is Ubuntu 18.04LTS Base Image"
  default     = "ami-0bcc094591f354be2"
}

variable "instance_type" {
  description = "type of EC2 instance to provision."
  default     = "t3.micro"
}

variable "name" {
  description = "Name to pass to Name tag"
  default     = "Provisioned by Terraform"
}

variable "sn_request" {
  description = "Request ID from ServiceNow"
  default     = "NULL"
}

# variable "aws_key_pair" {
#   type        = string
#   description = "The AWS Key Pair Name"
#   # TF_VAR_aws_key_pair=
# }
