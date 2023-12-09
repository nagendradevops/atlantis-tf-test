################################################################################
# VPC
################################################################################
variable "vpc_cidr_block" {}
variable "vpc_name" {}
variable "pub_sub1_cidr" {}
variable "pub_sub1_az" {}
variable "pub_sub2_cidr" {}
variable "pub_sub2_az" {}
variable "rt_destination_cidr" {}
variable "region" {}
variable "profile" {}
variable "priv_sub1_cidr" {}
variable "priv_sub1_az" {}
variable "priv_sub2_cidr" {}
variable "priv_sub2_az" {}

variable "public_subnet_names" {
  description = "Explicit values to use in the Name tag on public subnets. If empty, Name tags are generated"
  type        = list(string)
  default     = []
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}

variable "private_subnet_names" {
  description = "Explicit values to use in the Name tag on private subnets. If empty, Name tags are generated"
  type        = list(string)
  default     = []
}
variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}
