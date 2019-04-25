variable "vpc_cidr" {
  description = "cdir for the whole vpc"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "cidr for the public subnet"
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "cidr for the private subnet"
  default     = "10.0.1.0/24"
}

variable "key_pair" {
  description = "key pair for instance"
  default     = "demo-packer"
}
