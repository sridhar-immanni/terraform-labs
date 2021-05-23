# For NAT Gateway
resource "aws_eip" "sridhar-nat" {
  vpc = true
}

resource "aws_nat_gateway" "sridhar-nat-gw" {
  allocation_id = aws_eip.sridhar-nat.id
  subnet_id     = aws_subnet.sridhar-public.id
  depends_on    = [aws_internet_gateway.sridhar-gw]
  tags = {
	Name = "sridhar-nat"
 }
}

# For Route Table
resource "aws_route_table" "sridhar-private" {
  vpc_id = aws_vpc.sridhar-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.sridhar-nat-gw.id
  }
  tags = {
    Name = "sridhar-private"
  }
}

# For Route associations private
resource "aws_route_table_association" "sridhar-private-1-a" {
  subnet_id      = aws_subnet.sridhar-private-1.id
  route_table_id = aws_route_table.sridhar-private.id
}

resource "aws_route_table_association" "sridhar-private-1-b" {
  subnet_id      = aws_subnet.sridhar-private-2.id
  route_table_id = aws_route_table.sridhar-private.id
}

