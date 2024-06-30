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