resource "aws_vpc" "vpcfromterraform" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "mtc_VPC"
  }
}

resource "aws_subnet" "mtc_public_subnet" {
 
  count = length(var.public_cidrs)
  vpc_id = aws_vpc.vpcfromterraform.id
  cidr_block = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = ["ap-south-1a","ap-south-1b","ap-south-1c"][count.index]

  tags = {
    Name = "mtc_public_subnet${count.index + 1}"
  }
}

