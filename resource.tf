data "aws_ami" "ubuntu3" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Nodejs3"] # Filter ami with the value "Nodejs3 and gets the latest one"
  }

  owners = ["622960164406"]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Nodejs2"] # Filter ami with the value "Nodejs2 and gets the latest one"
  }

  owners = ["622960164406"]
}

data "aws_ami" "ubuntu2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Nodejs"] # Filter ami with the value "Nodejs and gets the latest one"
  }

  owners = ["622960164406"]
}

# Create the VPC(Virtual Private Cloud)
resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "terraform-vpc-aws"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_eip" "nat" {
  vpc = true
}

# Create the nat gateway
resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"

  tags {
    Name = "gw Nat"
  }

  depends_on = ["aws_internet_gateway.default"] # Ensures the internet gateway is created first
  subnet_id  = "${aws_subnet.public.id}"
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

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "Public subnet"
  }
}

# Create the route table association for the public subnet
resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}

# Create the private subnet
resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "us-east-2b"

  tags {
    Name = "Private subnet"
  }
}

# Create the route table for the private subnet
resource "aws_route_table" "nat" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.gw.id}"
  }

  tags {
    Name = "Private subnet"
  }
}

# Create the route table association for the private subnet specifying the subnet id and the route table id
resource "aws_route_table_association" "nat" {
  subnet_id      = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.nat.id}"
}

# Create the ec2 instance for the backend
resource "aws_instance" "backend" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  availability_zone      = "us-east-2b"
  instance_type          = "t2.micro"
  key_name               = "${var.key_pair}"
  vpc_security_group_ids = ["${aws_security_group.backend.id}"]
  subnet_id              = "${aws_subnet.private.id}"

  tags {
    Name = "backend"
  }
}

# Create the ec2 instance for the frontend
resource "aws_instance" "frontend" {
  ami                         = "${data.aws_ami.ubuntu2.id}"
  availability_zone           = "us-east-2b"
  instance_type               = "t2.micro"
  key_name                    = "${var.key_pair}"
  vpc_security_group_ids      = ["${aws_security_group.frontend.id}"]
  subnet_id                   = "${aws_subnet.public.id}"
  associate_public_ip_address = true

  tags {
    Name = "frontend"
  }
}

# Create the ec2 instance for the database
resource "aws_instance" "database" {
  ami                    = "${data.aws_ami.ubuntu3.id}"
  availability_zone      = "us-east-2b"
  instance_type          = "t2.micro"
  key_name               = "${var.key_pair}"
  vpc_security_group_ids = ["${aws_security_group.database.id}"]
  subnet_id              = "${aws_subnet.private.id}"

  tags {
    Name = "database"
  }
}

# Outut the IP'S on the terminal
output "backend-ip" {
  value = "${aws_instance.backend.private_ip}"
}

output "frontend-ip" {
  value = "${aws_instance.frontend.public_ip}"
}

output "database-ip" {
  value = "${aws_instance.database.private_ip}"
}
