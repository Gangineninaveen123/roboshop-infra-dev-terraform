locals {
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    # split functionality -> divides a single string into a list of substrings based on a specified separator, below one best example, converting that single string into 2 sub strings, taking the first one 😁
    #minimum , there should be 2 subnet ids, that is below.
    private_subnet_id = split("," , data.aws_ssm_parameter.private_subnet_ids.value)[0] # converted to list strings, and 0th index is 1 st one we need that, using it-> private subnet [zone.]
    ami_id = data.aws_ami.joindevops.id #here i am getting ami_id through data sources-> data.tf[refer it]
    catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
   
    #common tags
    common_tags = {
        Project = var.project
        Environment = var.environment
        Terraform = "true"
    }

}

