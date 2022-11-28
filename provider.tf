terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

###### Configure the AWS Provider ######
provider "aws" {
  region = var.region
}

/*provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}*/
  
provider "kubernetes" {
host = aws_eks_cluster.eks_cluster.endpoint
cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority.0.data)
exec {
api_version = "client.authentication.k8s.io/v1alpha1"
args = ["eks", "get-token", "--cluster-name", var.eks_name]
command = "aws"
}
}
