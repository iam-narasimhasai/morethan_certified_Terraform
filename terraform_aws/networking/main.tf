resource "aws_vpc" "vpcfromterraform" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "mtc_VPC"
  }
}