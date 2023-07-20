# we wil define the common variables only for this developement environment 
# later, when we'll need to create another env, that's when you'll need to update most of them 
# For example, I want to share the "dev" environment prefix across all modules in this env
locals {
    env = "staging"
}