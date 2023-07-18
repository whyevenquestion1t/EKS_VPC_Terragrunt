# Since we'll be creating additional K8s add-ons modules, 
# we want to expose some variables that can be passed to another module:


# For example, the full EKS name that includes the environment prefix
output "eks_name" {
  value = aws_eks_cluster.this.name
}

# To deploy cluster autoscaler, we'll need to use this OpenID provider arn to establish trust between AWS IAM and the K8s service account
output "openid_provider_arn" {
  value = aws_iam_openid_connect_provider.this[0].arn
}

