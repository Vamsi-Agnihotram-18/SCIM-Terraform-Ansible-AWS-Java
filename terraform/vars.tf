# Creating a Variable for ami of type map


variable "ec2_ami" {
  type = map(any)

  default = {
    us-east-1 = "ami-053b0d53c279acc90"
  }
}

# Creating a Variable for region

variable "region" {
  default = "us-east-1"
}


# Creating a Variable for instance_type
variable "instance_type" {
  type = string
}