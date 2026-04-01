# Public Subnet (AZ1a)
resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.aws_study_vpc.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "aws-study-subnet1a"
  }
}

# Public Subnet (AZ1c)
resource "aws_subnet" "public_subnet_1c" {
  vpc_id                  = aws_vpc.aws_study_vpc.id
  cidr_block              = "10.0.16.0/20"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "aws-study-subnet1c"
  }
}

# Private Subnet (AZ1a)
resource "aws_subnet" "private_subnet_1a" {
  vpc_id                  = aws_vpc.aws_study_vpc.id
  cidr_block              = "10.0.32.0/20"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "aws-study-private-subnet1a"
  }
}

# Private Subnet (AZ1c)
resource "aws_subnet" "private_subnet_1c" {
  vpc_id                  = aws_vpc.aws_study_vpc.id
  cidr_block              = "10.0.48.0/20"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "aws-study-private-subnet1c"
  }
}