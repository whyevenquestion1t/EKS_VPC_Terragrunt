output "vpc_id" {
    value = module.vpc.vpc_id
}

output "private_subnet_ids" {
    value = module.vpc.private_subnets_ids
}

output "public_subnet_ids" {
    value = module.vpc.public_subnets_ids
}

