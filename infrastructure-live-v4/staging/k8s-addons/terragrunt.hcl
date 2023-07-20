terraform {
  source = "../../../infrastructure-modules/k8s-addons"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  env      = include.env.locals.env
  eks_name = dependency.eks.outputs.eks_name
  openid_provider_arn = dependency.eks.outputs.openid_provider_arn

  enable_cluster_autoscaler      = true
  cluster_autoscaler_helm_verion = "9.28.0"
}

dependency "eks" {
  config_path = "../eks"

  mock_outputs = {
    eks_name            = "demo"
    openid_provider_arn = "arn:aws:iam::123456789012:oidc-provider"
  }
}

generate "helm_provider" {
  path      = "helm-provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF

data "aws_eks_cluster" "eks" {
    name = var.eks_name
}

data "aws_eks_cluster_auth" "eks" {
    name = var.eks_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.eks.name]
      command     = "aws"
    }
  }
}
EOF
}


# The tricky part is to authenticate helm provider, which we will generate using Terragrunt.
# Keep in mind that you cannot pass variables from the EKS module here.
# This provider will be generated and can only use variables that provided to the module itself.
# Essentially, you can generate anything you want.

# To initialize the Helm provider, we neeed to get a temporary token.
# You can pretty much initialize any provider that needs to authenticate with EKS using the same principle,
# such as the K8s and kubectl Terraform providers.  