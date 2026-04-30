# ============================================================
# VPC
# ============================================================
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "lab1-vpc"
  }
}

# ============================================================
# Default Security Group
# ============================================================
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "lab1-default-sg"
  }
}

# ============================================================
# Internet Gateway
# ============================================================
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "lab1"
  }
}

# ============================================================
# Public Subnets
# ============================================================
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "lab1-public-subnet"
  }
}

# ============================================================
# Private Subnets
# ============================================================
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "lab1-private-subnet"
  }
}

# ============================================================
# NAT Gateway
# ============================================================
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "lab1-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "lab1-nat-gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

# ============================================================
# Public Route Table
# ============================================================
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "lab1-public-rt"
  }
}

# ============================================================
# Private Route Table
# ============================================================
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "lab1-private-rt"
  }
}

resource "aws_route_table_association" "public_associate" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_associate" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}