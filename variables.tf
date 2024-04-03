variable "region" {
    description = "AWS Region to deploy resources"
    type = string
    default = "eu-west-2"
}

variable "hcp_client_id" {
}
variable "hcp_secret_id" {
}
variable "instance_size" {
  default = "t2.micro"
}
