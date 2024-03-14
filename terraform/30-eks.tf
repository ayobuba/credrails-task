
################################
## Setting up the EKS Cluster ##
################################
module "this-eks" {
  source                                             = "terraform-aws-modules/eks/aws"
  version                                            = "17.22.0"
  cluster_name                                       = local.cluster_name
  cluster_version                                    = "1.27"
  vpc_id                                             = module.this-vpc.vpc_id
  subnets                                            = module.this-vpc.private_subnets
  worker_create_cluster_primary_security_group_rules = true
  map_roles = [
    {
      rolearn  = "arn:aws:iam::557968956216:role/cloudcraft"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["cloudcraft-view-only"]
    },
  ]

  tags = {
    Environment = var.app_stage
    GithubRepo  = "https://github.com/ayobuba/credrails-task"
    GithubOrg   = "ayobuba"
  }
  node_groups = {
    spot-1 = {
      name             = "credrails-spot-1a"
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"
      k8s_labels = {
        Environment = "dev"
        GithubRepo  = "credrails-task"
        GithubOrg   = "credrails"
      }
      additional_tags = {
        ExtraTag = "node-group-1"
      }
    },
    spot-2 = {
      name             = "credrails-spot-1b"
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1

      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
      k8s_labels = {
        Environment = "dev"
        GithubRepo  = "credrails-task"
        GithubOrg   = "credrails"
      }
      additional_tags = {
        ExtraTag = "node-group-2"
        name     = "node-22"
      }
    }
  }

  depends_on = [
    module.this-vpc
  ]
}



############################
## Null Resource for EKS  ##
############################
resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${local.cluster_name} --profile ${var.aws_profile}"
  }
  depends_on = [
    module.this-eks
  ]
}
