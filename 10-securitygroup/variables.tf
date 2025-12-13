variable "project" {
    type = string
    default = "roboshop"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "frontend_sg_name" {
    type = string
    default = "frontend"
}

variable "frontend_sg_discription" {
    type = string
    default = "Created sg for frontend instance"
}

variable "bastion_sg_name" {
    type = string
    default = "bastion"
}

variable "bastion_sg_discription" {
    type = string
    default = "Created bastion_sg for bastion instance"
}