variable "project" {
    type = string
    default = "roboshop-vpc-12sept-2026" # i have error, instead vpc, it should be sg, u can ignore.
}

variable "environment" {
    type = string
    default = "dev-vpc-12sept-2026" # i have error, instead vpc, it should be sg, u can ignore
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
    default = "bastion-sg"
}

variable "bastion_sg_discription" {
    type = string
    default = "Created bastion_sg for bastion instance"
}

