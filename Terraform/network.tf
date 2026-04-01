# Internet Gateway
resource "aws_internet_gateway" "aws_study_igw" {
  vpc_id = aws_vpc.aws_study_vpc.id

  tags = {
    Name = "aws-study-gw"
  }
}

# Route Table
resource "aws_route_table" "aws_study_route_table" {
  vpc_id = aws_vpc.aws_study_vpc.id

  tags = {
    Name = "aws-study-route"
  }
}

# Route (Internet向け)
resource "aws_route" "internet_route" {
  route_table_id         = aws_route_table.aws_study_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.aws_study_igw.id
}

# Public Subnet1a にRouteTableを関連付け
resource "aws_route_table_association" "public_subnet_1a_association" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.aws_study_route_table.id
}

# Public Subnet1c にRouteTableを関連付け
resource "aws_route_table_association" "public_subnet_1c_association" {
  subnet_id      = aws_subnet.public_subnet_1c.id
  route_table_id = aws_route_table.aws_study_route_table.id
}