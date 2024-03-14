output "app_prefix" {
  value = local.name_prefix
}

output "vpc_id" {
  value = module.this-vpc.vpc_id
}

output "private-subnets" {
  value = module.this-vpc.private_subnets
}

output "public-subnet" {
  value = module.this-vpc.public_subnets
}


output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.this-eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.this-eks.cluster_endpoint
}
output "nginx_kubectl_config" {
  description = "kubectl config as generated by the module."
  value       = module.this-eks.kubeconfig
}

output "config_map_aws_auth" {
  description = "A kubernetes configuration to authenticate to this EKS cluster."
  value       = module.this-eks.config_map_aws_auth
}


output "cluster-token" {
  value     = data.aws_eks_cluster_auth.cluster.token
  sensitive = true
}

output "cluster-ca-cert" {
  value     = data.aws_eks_cluster.cluster.certificate_authority.0.data
  sensitive = true
}


output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}

#RDS
output "db_endpoint" {
  value = aws_db_instance.credrails-rds.endpoint
}

output "db_name" {
  value = aws_db_instance.credrails-rds.name
}

