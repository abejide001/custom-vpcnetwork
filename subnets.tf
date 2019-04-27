# Create the private subnet
resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "us-east-2b"

  tags {
    Name = "Private subnet"
  }
}

# Create the public subnet
resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "us-east-2b"

  tags {
    Name = "Public subnet"
  }
}
