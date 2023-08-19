variable "region" {
  type    = string
  default = "us-east-1"
}

variable "profile" {
  type    = string
  default = "default"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-08a52ddb321b32a8c"
  }
}

variable "bastion-allow-ip" {
  type = string
}
