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

variable "mongodb_ports_vpn" {
    type = list(string)
    description = "mongodb_ports"
    default = [22, 27017]

}

variable "redis_ports_vpn" {
    type = list(string)
    description = "redis_ports"
    default = [22, 6379]

}

variable "mysql_ports_vpn" {
    type = list(string)
    description = "mysql_ports"
    default = [22, 3306]

}

variable "rabbitmq_ports_vpn" {
    type = list(string)
    description = "rabbitmq_ports"
    default = [22, 5672]

}