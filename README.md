# Create a Custom Network for your Checkpoint
<img width="773" alt="Screenshot 2019-04-25 at 9 40 27 AM" src="https://user-images.githubusercontent.com/6943256/56722171-644e5800-673e-11e9-9ee7-82dfac4ac212.png">
**Infrastructure Diagram**

## Technologies Used
- [Packer](www.packer.io)
- [Terraform](www.terraform.io)
- [Ansible](www.ansible.com)
- [AWS](aws.amazon.com)

## Introduction
This repository automates the creation of VPC(Virtual Private Cloud), a Public and Private subnets, Internet gateway, Route tables e.t.c. The application API and database reside in a private subnet(not accessible via the internet), the frontend resides in a public subnet(accessible via the internet), as shown in the image above

## How the script works
There are two packer files, one for database, and the other for the backend api, the packer file for the front-end, can be found in this [repo](https://github.com/abejide001/AWS-EC2-Instance-with-Packer-and-Ansible/tree/use-terraform-for-provisioning)

**Packer file for the database**
<img width="863" alt="Screenshot 2019-04-28 at 12 32 40 AM" src="https://user-images.githubusercontent.com/6943256/56856190-2e32f300-694d-11e9-9e50-b6cd60c084d0.png">
This file creates the database image, and can be run with the command 

```bash
$ packer build packer-database.json
````
**Packer file for the backend**
<img width="878" alt="Screenshot 2019-04-28 at 12 36 44 AM" src="https://user-images.githubusercontent.com/6943256/56856221-be713800-694d-11e9-82da-573d9ef4dd2e.png">
This file creates the backend image, and can be run with the command 

```bash
$ packer build packer-backend.json
````

Variables were specified in the `variable.tf` file, with a default and description field
<img width="895" alt="Screenshot 2019-04-27 at 10 39 38 PM" src="https://user-images.githubusercontent.com/6943256/56855339-69c5c100-693d-11e9-9af4-5c90d25af5b4.png">
- vpc_cidr
- public_subnet_cidr
- private_subnet_cidr
- key_pair

The **provider** being is used is `aws` and the region `us-east-2`
<img width="618" alt="Screenshot 2019-04-28 at 12 38 47 AM" src="https://user-images.githubusercontent.com/6943256/56856238-1c058480-694e-11e9-9e06-0b6c44f5bec7.png">

The **vpc**(virtual private cloud) name can be seen in the `vpc.tf` file, Virtual Private Cloud (VPC) lets you provision a logically isolated section of the AWS Cloud where you can launch AWS resources in a virtual network that you define
<img width="883" alt="Screenshot 2019-04-28 at 12 56 43 AM" src="https://user-images.githubusercontent.com/6943256/56856345-a51dbb00-6950-11e9-985e-7da01f512c6d.png">

A **private** and a **public** **subnet** was created, the frontend uses the public subnet while the backend and database uses the private subnet, A subnet is a logical partition of an IP network into multiple, smaller network segments. It is typically used to subdivide large networks into smaller, more efficient subnetworks.
<img width="877" alt="Screenshot 2019-04-28 at 12 59 02 AM" src="https://user-images.githubusercontent.com/6943256/56856357-fc239000-6950-11e9-86fa-5fcd468cbe0a.png">

The file below, creates an **internet gateway**, this allows the frontend resource to communicate with the internet
<img width="539" alt="Screenshot 2019-04-28 at 1 05 47 AM" src="https://user-images.githubusercontent.com/6943256/56856421-d0ed7080-6951-11e9-952a-aa2e50347825.png">

**Network address translation** (NAT) gateway enable instances in a private subnet to connect to the internet or other AWS services, but prevent the internet from initiating a connection with those instances.
<img width="754" alt="Screenshot 2019-04-28 at 1 25 25 AM" src="https://user-images.githubusercontent.com/6943256/56856528-8de0cc80-6954-11e9-9ec6-78aced227a2b.png">

The **route table** contains a set of rules, called routes, that are used to determine where network traffic is directed
<img width="877" alt="Screenshot 2019-04-28 at 12 59 02 AM" src="https://user-images.githubusercontent.com/6943256/56856500-df3c8c00-6953-11e9-9e52-89cec726d92d.png">

The route tables are being associated with various subnets in the **route table association**
<img width="877" alt="Screenshot 2019-04-28 at 12 59 02 AM" src="https://user-images.githubusercontent.com/6943256/56856517-42c6b980-6954-11e9-88aa-c5d4effec1b7.png">

The **security group** acts as a virtual firewall for your instance to control inbound and outbound traffic. When you launch an instance in a VPC, you can assign up to five security groups to the instance. Security groups act at the instance level, not the subnet level
```
resource "aws_security_group" "backend" {
  name        = "backend"
  description = "Allow all incoming connections"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6000
    to_port     = 6000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0             # Allow All
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "backend"
  }
}

resource "aws_security_group" "frontend" {
  name        = "frontend"
  description = "Allow all incoming connections"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0             # Allow All
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "frontend"
  }
}

resource "aws_security_group" "database" {
  name        = "database"
  description = "Allow all incoming connections"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0             # Allow All
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "database"
  }
}

resource "aws_security_group" "bastion-nat-sg" {
  name        = "bastion-nat-sg"
  description = "Security group for the Bastion Host and NAT Instance"

  # inbound traffic
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags = {
    Name = "bastion_nat_security_group"
  }
}
```
The security group is being specified for the backend, frontend, and database, with the **inbound** and **outbound** rules

The data used to source for the ami that was created with packer, is specified in `data.tf` file
```
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
```
A filter is being done with the values of the ami

Finally, the instances are created with the configuration
```
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
```
## How to run the script
Run the following commands
```bash
$ terraform validate
```
The terraform validate command is used to validate the syntax of the terraform files

```bash
$ terraform plan
```
The terraform plan command is used to create an execution plan

```bash
$ terraform apply
```
The terraform apply command is used to apply the changes required to reach the desired state of the configuration, or the pre-determined set of actions generated by a terraform plan execution plan

To destroy the resources created, run the command

```bash
$ terraform destroy
```




