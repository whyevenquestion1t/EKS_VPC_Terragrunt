# referencing the module that we have created
terraform {
    source = "git@github.com:whyevenquestion1t/infrastructure-modules.git//eks?ref=eks-v0.0.1"
}

include "root" {
    path = find_in_parent_folders()
}

include "env" {
    path = find_in_parent_folders("env.hcl")
    expose = true
    merge_strategy = "no_merge"
}

inputs = {
    eks_version = "1.27"
    env =  include.env.locals.env
    eks_name = "demo"
    subnet_ids = dependency.vpc.outputs.private_subnet_ids
    # This is where Terragrunt really *shines* - it allows us to define dependencies between modules. For example,
    # EKS module depends on the VPC module and subnet IDs  
    # With plain Terraform, you would need to use the Terraform remote state and execute those modules sequentially 


    # Next, we need to create a "node_groups" variable with the desired settings for the group 
    node_groups = {
        general = {
            capacity_type = "ON_DEMAND"
            instance_types = ["t3a.xlarge"]
            scaling_config = {
                desired_size = 1
                max_size = 10
                min_size = 0
            }
        }
    }
}

dependency "vpc" { 
    # simply point to the vpc module to define a dependency 
    config_path = "../vpc"

    # it's also important to provide some mock outputs, 
    # this is helpful when you want to run "terragrunt run-all plan" on both modules simultaniously
    # if you omit this mock output variable - the plan will exit with an Error stating that EKS module needs SubnetIDs
    mock_outputs = {
        private_subnet_ids = ["subnet-123", "subnet-456"]
    }
}
