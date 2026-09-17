locals {
    ami_id = data.aws_ami.joindevops.id #here i am getting ami_id through data sources-> data.tf[refer it]
    mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value #here i am getting vpn_sg_id through data sources-> data.tf[refer it]
    mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value #here i am getting vpn_sg_id through data sources-> data.tf[refer it]
    redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value #here i am getting vpn_sg_id through data sources-> data.tf[refer it]
    rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value #here i am getting vpn_sg_id through data sources-> data.tf[refer it]
    #split functionality -> divides a single string into a list of substrings based on a specified separator, below one best example, converting that single string into 2 sub strings, taking the first one 😁
    database_subnet_id = split("," , data.aws_ssm_parameter.database_subnet_ids.value)[0] # converted to list strings, and 0th index is 1 st one we need that, using it-> public subnet [zone.]
  
    #common tags
    common_tags = {
        Project = var.project
        Environment = var.environment
        Terraform = "true"
    }
}
