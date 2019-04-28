data "aws_ami" "ubuntu3" {
  most_recent = true

  filter {
    name   = "name"
    values = ["database"] # Filter ami with the value "database and gets the latest one"
  }

  owners = ["622960164406"]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["backend"] # Filter ami with the value "backend and gets the latest one"
  }

  owners = ["622960164406"]
}

data "aws_ami" "ubuntu2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["frontend"] # Filter ami with the value "frontend and gets the latest one"
  }

  owners = ["622960164406"]
}