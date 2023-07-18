# Let's provide the variables that we need to provide for this module

# First, we'll use the same env variable as a prefix  
variable "env" {
  description = "Environment name"
  type       = string
}

# Then, we'll specify the desired EKS version and the name of the EKS cluster
variable "eks_version" {
  description = "Desired K8S master version"
  type        = string
}
variable "eks_name" {
  description = "Name of the cluster"
  type        = string
}

# Next, we'll provide the list of subnet IDs that we want to pass to EKS
variable "subnet_ids" {
  description = "List of the subnet IDs. Must be in at least two different AZs"
  type        = list(string)
}

# Next, default IAM policies that we have to attach to the EKS nodes
variable "node_iam_policies" {
  description = "List of IAM Policies to attach to EKS-managed nodes"
  type        = map(any)
  default = {
    1 = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    2 = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    4 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}

# Lastly, we'll define the node groups, specifying all the parameters of the desired K8s node
variable "node_groups" {
    description = "EKS node groups"
    type = map(any)
}

# Finally, we'll add the "enable_irsa" flag to create the OpenID Connect provider 
variable "enable_irsa" {
    description = "Determines whether to create an OpenID Connect Provider for EKS"
    type = bool
    default = true
}