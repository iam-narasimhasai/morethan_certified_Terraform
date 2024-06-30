variable "aws_region" {
  default = "ap-south-1"
}
variable "cidr_block" {
  type = string
}
variable "public_cidrs" {
  type = list(string)
}
variable "private_cidrs" {
  type = list(string)
}
variable "ports" {
  type = list(number)
}
variable "pr_ports" {
  type = list(number)
}
variable "dbsgbool" {
  type = bool
}
variable "db_storage" {}
variable "db_instance_class" {}
variable "dbname" {}
variable "dbuser" {}
variable "dbpassword" {}
variable "vpc_security_group_ids" {}
variable "db_subnet_group_name" {}
variable "db_engine_version" {}
variable "db_identifier" {}
variable "skip_db_snapshot" {}