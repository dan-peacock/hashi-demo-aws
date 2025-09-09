provider "aws" {
  region = var.region
}

variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-2"
}

variable "instance_size" {
  description = "EC2 instance size"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Static AMI ID to use (must exist in the chosen region)"
  type        = string
  default     = "ami-0123456789abcdef0" # <-- replace with your chosen AMI
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_size

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<html><body><div>Hello, world!</div></body></html>" > /var/www/html/index.html
  EOF

  tags = {
    Name = "static-ami-web"
  }
}
