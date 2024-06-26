variable "aws_region" {
  default = "ap-south-1"
}
variable "cidr_block" {
  type = string
}
variable "public_cidrs" {
  type = list(string)
}