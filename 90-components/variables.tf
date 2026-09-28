variable "components" {
    default = {

        catalogue = {
            
            rule_priority = 10
        }

        user = {
            
            rule_priority = 20
        }
        cart = {
            
            rule_priority = 30
        }

        shipping = {
            
            rule_priority = 40
        }

        payment = {
            
            rule_priority = 50
        }

        frontend = {
            
            rule_priority = 10 # this is different listner so giving 10 here, same listner means, priority should be given different.
        }
    }

}