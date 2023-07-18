data "tls_certificate" "this" {
  count = var.enable_irsa ? 1 : 0
  # boolean flag to enable irsa that we can use to create this provider on demand 

  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "this" {
  count = var.enable_irsa ? 1 : 0
  # once you have retrieved EKS TLS certificate, you can proceed to create the OpenID Connect provider 

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.this[0].certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.this.identity[0].oidc[0].issuer

}

