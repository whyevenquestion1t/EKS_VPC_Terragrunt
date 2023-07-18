variable "env" {
    description = "Environment name"
    type = string
}

variable "eks_name" {
  description = "Name of the cluster"
  type = string
}

variable "enable_cluster_autoscaler" {
    description = "Determines whether to deploy cluster autoscaler"
    type = bool 
    default = false
}

variable "cluster_autoscaler_helm_version" {
  description = "Cluster Autoscaler Helm vesrion"
  type        = string
}

variable "openid_provider_arn" {
    description = "OpenID Connect Provider ARN"
    type = string
  
}

