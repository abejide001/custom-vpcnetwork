# Create the VPC(Virtual Private Cloud)
resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "terraform-vpc-aws"
  }
}