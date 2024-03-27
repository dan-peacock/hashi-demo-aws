provider "aws" {
  region = var.region
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_secret_id
}

// data "aws_ami" "amazon_linux" {
//   most_recent = true
//   owners    = ["amazon"]

//   filter {
//     name   = "name"
//     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
//   }
// }

data "hcp_packer_artifact" "ubuntu" {
  bucket_name   = "ubuntu"
  channel_name  = "First-version"
  platform      = "aws"
  region        = "us-east-2"
}

resource "aws_instance" "web" {
  ami           = data.hcp_packer_artifact.ubuntu.id
  instance_type = "t2.micro"

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<html><body><div>Hello, world!</div></body></html>" > /var/www/html/index.html
    EOF

  #tags = var.tags
}
