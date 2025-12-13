module "vpc" {
    #source = "../Module-terraform-aws-VPC"  # from local we are reffring too
    source = "git::https://github.com/Gangineninaveen123/Module-terraform-aws-VPC.git?ref=main" #while reffering from the git , the source, i am taking from git, after i pushed the VPC module TO GIT, i am using through source as git 😁
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

/* #this is only for testing , wheteher vpc id printing or not , while doing terraform plan and terraform apply -auto-approve
output "vpc_id"{
    value = module.vpc.vpc_id #, here to get vpc_id from outputs, its already came to our modules, beacause we are using that module, and last [vpc_id ], we should use same one which is used in the module, that is mandatory...

} */

/* # for, checking, the created public_subnets, which is in the outputs.tf, folder, printing or not...
output "public_subnet_ids" {
    value = module.vpc.public_subnet_ids
} */