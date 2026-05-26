module "vpc" {
    #source = "../Module-terraform-aws-VPC"  # from local we are reffring too
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-VPC.git?ref=main" #while reffering from the git , we ll give like this
    /* the below details were mentioned in variables, and few below other details too, u ll understand the code no worries......
     project = "roboshop"
    environment = "dev"
    public_subnet_cidr = ["10.0.1.0/24", "10.0.2.0/24"] */

    project = var.project
    environment = var.environment
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    database_subnet_cidr = var.database_subnet_cidr

    is_peering_required = true

}