resource "aws_security_group" "devops_sg" {
    name        = "devops-sg"
    description = "Security group for DevOpsS instance"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 2379
        to_port     = 2380
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 6443
        to_port     = 6443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 10250
        to_port     = 10250
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 10257
        to_port     = 10257
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 10259
        to_port     = 10259
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 30000
        to_port     = 32767
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 8472
        to_port     = 8472
        protocol    = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }
   
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "devops-sg"
    }
}


resource "aws_instance" "my-machine" {
  # Creates four identical aws ec2 instances
  count = 3

  # All four instances will have the same ami and instance_type
  ami           = lookup(var.ec2_ami, var.region)
  key_name = "devops"
  instance_type = var.instance_type # 
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  tags = {
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 0 and corresponding to this instance.
    Name = "my-machine-${count.index}"
  }
}

output "ec2_global_ips" {
  value = ["${aws_instance.my-machine.*.public_ip}"]
}
