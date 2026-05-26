output "aws_availability_zones" {
    # availability_zones_info -> this name comes from data.tf, where output is also written there for this to get availability zones from us-east-1
    value = module.vpc.availability_zones_info   # this output is coming from module vpc, verify that properly from data.tf[from module].
}

