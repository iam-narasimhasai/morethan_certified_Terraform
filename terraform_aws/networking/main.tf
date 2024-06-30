resource "aws_vpc" "vpcfromterraform" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "mtc_VPC"
  }
}
data "aws_availability_zones" "az" {}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpcfromterraform.id
  tags = {
    Name = "IGWforvpc"
  }
}
resource "aws_subnet" "mtc_public_subnet" {
 
  count = length(var.public_cidrs)
  vpc_id = aws_vpc.vpcfromterraform.id
  cidr_block = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.az.names[count.index]
  #availability_zone = ["ap-south-1a","ap-south-1b","ap-south-1c"][count.index]

  tags = {
    Name = "mtc_public_subnet${count.index + 1}"
  }
}



resource "aws_subnet" "mtc_private_subnet" {
  count = length(var.private_cidrs)
  vpc_id = aws_vpc.vpcfromterraform.id
  cidr_block = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.az.names[count.index]
  #availability_zone = ["ap-south-1a","ap-south-1b","ap-south-1c"][count.index]

  tags = {
    Name = "mtc_private_subnet${count.index+1}"
  }
}

resource "aws_route_table" "public_route" {
  
  vpc_id = aws_vpc.vpcfromterraform.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "public_route_table"
  }

}

resource "aws_route_table" "private_route" {
  
  vpc_id = aws_vpc.vpcfromterraform.id
  
  tags = {
    Name = "private_route_table"
  }

}




resource "aws_route_table_association" "public_route_association" {
  count = length(aws_subnet.mtc_public_subnet)
  subnet_id = aws_subnet.mtc_public_subnet[count.index].id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private_route_association" {
 
count = length(aws_subnet.mtc_private_subnet)
subnet_id = aws_subnet.mtc_private_subnet[count.index].id
 route_table_id = aws_route_table.private_route.id

}


resource "aws_security_group" "mtc_sg" {
  vpc_id = aws_vpc.vpcfromterraform.id
  name = "public_sg"

  description = "sg for public access"
  dynamic "ingress" {
    for_each = var.ports
    iterator = x
    content{
      from_port = x.value
      to_port = x.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# aws_db_subnet_group

resource "aws_db_subnet_group" "dbsecuritygroup" {
  count = var.dbsgbool ? 1 : 0
  subnet_ids = aws_subnet.mtc_private_subnet[*].id
  tags = {
    Name = "dbsg"
  }

}