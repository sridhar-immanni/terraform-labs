
# For VPC
resource "aws_vpc" "sridhar-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "sridhar-main"
  }
}

# For Subnets
resource "aws_subnet" "sridhar-public" {
  vpc_id                  = aws_vpc.sridhar-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2a"
  tags = {
    Name = "sridhar-public"
  }
}


resource "aws_subnet" "sridhar-private-1" {
  vpc_id                  = aws_vpc.sridhar-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2a"
  tags = {
    Name = "sridhar-private-1"
  }
}

resource "aws_subnet" "sridhar-private-2" {
  vpc_id                  = aws_vpc.sridhar-vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2b"
  tags = {
    Name = "sridhar-private-2"
  }
}

# For Internet Gateway
resource "aws_internet_gateway" "sridhar-gw" {
  vpc_id = aws_vpc.sridhar-vpc.id
  tags = {
    Name = "sridhar-gw"
  }
}

# For Route Tables
resource "aws_route_table" "sridhar-public-rt" {
  vpc_id = aws_vpc.sridhar-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sridhar-gw.id
  }
  tags = {
    Name = "sridhar-public-rt"
  }
}

# For Route associations public
resource "aws_route_table_association" "sridhar-public-rt-1" {
  subnet_id      = aws_subnet.sridhar-public.id
  route_table_id = aws_route_table.sridhar-public-rt.id
}
