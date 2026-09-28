module "user" {
    source = "../../module-terraform-aws-roboshop"
    component = "user"
    rule_priority = 20
}