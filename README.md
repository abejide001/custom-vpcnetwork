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
