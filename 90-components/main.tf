module "component" {

    for_each = var.components
    #source = "../../module-terraform-aws-roboshop"
    source = "git::https://github.com/Gangineninaveen123/module-terraform-aws-roboshop.git?ref=main"
    component = each.key
    rule_priority = each.value.rule_priority # each.value, it will take all the rule priorities, so mentioned specifically, when cart is the component, take rule_priority of that.
}