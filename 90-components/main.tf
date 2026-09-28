module "component" {

    for_each = var.components
    source = "../../module-terraform-aws-roboshop"
    component = each.key
    rule_priority = each.value.rule_priority # each.value, it will take all the rule priorities, so mentioned specifically, when cart is the component, take rule_priority of that.
}