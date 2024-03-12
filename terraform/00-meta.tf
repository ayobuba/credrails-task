provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}
terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "3.75.1"
    }
  }
}

provider "random" {}
provider "local" {}
provider "null" {}
provider "template" {}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name,
      "--profile",
      var.aws_profile
    ]
  }
}

# DATA SOURCES
data "aws_vpc" "sc" {
  id = module.this-vpc.vpc_id
}

data "aws_caller_identity" "current" {}

data "aws_iam_account_alias" "current" {}

data "aws_availability_zones" "azs" {
  state = "available"
}

data "aws_autoscaling_groups" "groups" {
  filter {
    name   = "tag-key"
    values = ["eks:nodegroup-name"]
  }

  #  filter {
  #    name   = "eks:nodegroup-name"
  #    values = ["cpp-spot-1e"]
  #  }
}

data "aws_eks_cluster" "cluster" {
  name = module.this-eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.this-eks.cluster_id
}

data "aws_vpc" "default" {
  default = true
}


