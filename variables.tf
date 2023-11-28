variable "key_name" {
    description = "value of key_name"
    default = "EXAMPLE"    
    type = string
}

variable "ami" {
    description = "value of ami"
    default = "ami-06311c5f6a3951ada"
    type = string
}

variable "vpc_id" {
    description = "value of vpc"
    default = "vpc-67ae5f0c"
    type = string
}

variable "domain_name" {
    description = "value of domain_name"
    default = "example.com"
    type = string
  
}

variable "lb_name" {
    description = "value of lb_name"
    default = "example-lb"
    type = string
}

variable "target_port" {    
    description = "value of target_port"
    default = 10000
    type = number
}

variable "sub_domain" {
    description = "value of sub_domain"
    default = "test"
    type = string
}

variable "sg_name" {
    description = "value of security group name"
    default = "launch-wizard-8"
    type = string
}

variable "instance_name" {
    description = "value of ec2 name"
    default = "EC2 NAME"
    type = string
}

variable "instance_type" {
    description = "value of instance type"
    default = "t2.micro"
    type = string
}