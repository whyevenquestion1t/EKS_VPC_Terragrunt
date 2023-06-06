variable "env"{
    description = "Environment name"
    type = string
}

variable "vpc_cidr_block"{
    description = "CIDR"
    type = string
    default = "10.0.0.0/16"
}

variable "azs" {
    description = "Availability Zones"
    type = list(string)
}

variable "public_subnets" {
    description = "Public Subnets CIDRs"
    type = list(string)
}

variable "private_subnets" {
    description = "Private Subnets CIDRs"
    type = list(string)
}

variable "public_subnet_tags" {
    description = "public_subnet_tags"
    type = map(any)
}


variable "private_subnet_tags" {
    description = "private_subnet_tags"
    type = map(any)
}