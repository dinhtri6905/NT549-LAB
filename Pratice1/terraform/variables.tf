variable "aws_region" {
  description = "AWS Region"
  type = string
  default = "ap-southeast-1"
}

variable "project_name" {
  description = "Project name used as prefix for all resources"
  type = string 
  default = "nt548-lab1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  
}