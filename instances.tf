
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
