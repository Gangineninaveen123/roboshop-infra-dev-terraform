output "aws_availability_zones" {
    value = module.vpc.availability_zones_info   # this output is coming from module vpc, verify that properly.
}