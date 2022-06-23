
# VPC作成
resource "aws_vpc" "aws-tf-vpc" {
  cidr_block           = var.cidr_vpc
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "tf-example-vpc"
  }
}

# サブネット２つ作成(publicとprivate)
resource "aws_subnet" "aws-tf-public-subnet" {
  vpc_id            = aws_vpc.aws-tf-vpc.id
  cidr_block        = var.cidr_public
  availability_zone = var.public_az
  tags = {
    Name = "aws-tf-public-subnet-$(var.public_az)"
  }
}

resource "aws_subnet" "aws-tf-private-subnet" {
  vpc_id            = aws_vpc.aws-tf-vpc.id
  cidr_block        = var.cidr_private
  availability_zone = var.private_az
  tags = {
    Name = "aws-tf-private-subnet-$(var.private_az)"
  }
}

# インターネットゲートウェイの作成
resource "aws_internet_gateway" "aws-tf-igw" {
  vpc_id = aws_vpc.aws-tf-vpc.id
  tags = {
    Name = "aws-tf-igw"
  }
}

# ルートテーブルの作成
resource "aws_route_table" "aws-tf-public-route" {
  vpc_id = aws_vpc.aws-tf-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-tf-igw.id
  }
  tags = {
    Name = "aws-tf-public-route"
  }
}

# サブネットの関連付けでルートテーブルをパブリックサブネットに紐付け
resource "aws_route_table_association" "aws-tf-public-subnet-association" {
  subnet_id      = aws_subnet.aws-tf-public-subnet.id
  route_table_id = aws_route_table.aws-tf-public-route.id
}
