locals {
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    # split functionality -> divides a single string into a list of substrings based on a specified separator, below one best example, converting that single string into 2 sub strings, taking the first one 😁
    #minimum , there should be 2 subnet ids, that is below.
    public_subnet_ids = split("," , data.aws_ssm_parameter.public_subnet_ids.value) # converted to list strings, and 0th index is 1 st one we need that, using it-> private subnet [zone.]
    frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value #, this backend_alb_sg_id comes from data source, check for more info in it.
    acm_certificate_arn = data.aws_ssm_parameter.acm_certificate_arn.value
    
    #common tags
    common_tags = {
        Project = var.project
        Environment = var.environment
        Terraform = "true"
    }

}

