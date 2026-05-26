variable "project" {
    type = string
    default = "roboshop-vpc-may27-2026"
}

variable "environment" {
    type = string
    default = "dev-vpc-may27-2026"
}

variable "public_subnet_cidr"{
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr"{
    type = list(string)
    default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidr"{
    type = list(string)
    default = ["10.0.21.0/24", "10.0.22.0/24"]
}
   
