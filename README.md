# Create a Custom Network for your Checkpoint
<img width="773" alt="Screenshot 2019-04-25 at 9 40 27 AM" src="https://user-images.githubusercontent.com/6943256/56722171-644e5800-673e-11e9-9ee7-82dfac4ac212.png">
**Infrastructure Diagram**

## Technologies Used
- [Packer](www.packer.io)
- [Terraform](www.terraform.io)
- [Ansible](www.ansible.com)
- [AWS](aws.amazon.com)

## Introduction
This repository automates the creation of VPC(Virtual Private Cloud), a Public and Private subnets. The application API and database reside in a private subnet(not accessible via the internet), the frontend resides in a public subnet(accessible via the internet), as shown in the image above

## How the script works
Variables were specified in the `variable.tf` file, with a default and description field
<img width="895" alt="Screenshot 2019-04-27 at 10 39 38 PM" src="https://user-images.githubusercontent.com/6943256/56855339-69c5c100-693d-11e9-9af4-5c90d25af5b4.png">
- vpc_cidr
- public_subnet_cidr
- private_subnet_cidr
- key_pair

The **provider** being is used is `aws` and the region `us-east-2`
<img width="618" alt="Screenshot 2019-04-28 at 12 38 47 AM" src="https://user-images.githubusercontent.com/6943256/56856238-1c058480-694e-11e9-9e06-0b6c44f5bec7.png">

The **vpc**(virtual private cloud) name can be seen in the `vpc.tf` file as `terraform-aws-vpc`
<img width="883" alt="Screenshot 2019-04-28 at 12 56 43 AM" src="https://user-images.githubusercontent.com/6943256/56856345-a51dbb00-6950-11e9-985e-7da01f512c6d.png">

A **private** and a **public** **subnet** was created, the frontend uses the public subnet while the backend and database uses the private subnet, A subnet is a logical partition of an IP network into multiple, smaller network segments. It is typically used to subdivide large networks into smaller, more efficient subnetworks.
<img width="877" alt="Screenshot 2019-04-28 at 12 59 02 AM" src="https://user-images.githubusercontent.com/6943256/56856357-fc239000-6950-11e9-86fa-5fcd468cbe0a.png">

The file below, creates an **internet gateway**, this allows the frontend resource to communicate with the internet
<img width="539" alt="Screenshot 2019-04-28 at 1 05 47 AM" src="https://user-images.githubusercontent.com/6943256/56856421-d0ed7080-6951-11e9-952a-aa2e50347825.png">



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

