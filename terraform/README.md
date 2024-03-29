<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.75.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.1 |
| <a name="provider_aws.central"></a> [aws.central](#provider\_aws.central) | 3.75.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this-eks"></a> [this-eks](#module\_this-eks) | terraform-aws-modules/eks/aws | 17.22.0 |
| <a name="module_this-vpc"></a> [this-vpc](#module\_this-vpc) | terraform-aws-modules/vpc/aws | 3.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.credrails-rds](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/resources/db_instance) | resource |
| [aws_security_group.all_worker_mgmt](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/resources/security_group) | resource |
| [aws_security_group.worker_group_mgmt_one](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/resources/security_group) | resource |
| [aws_security_group.worker_group_mgmt_two](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/resources/security_group) | resource |
| [null_resource.kubectl](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_autoscaling_groups.groups](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/data-sources/autoscaling_groups) | data source |
| [aws_availability_zones.azs](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_account_alias.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/data-sources/iam_account_alias) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/data-sources/vpc) | data source |
| [aws_vpc.sc](https://registry.terraform.io/providers/hashicorp/aws/3.75.1/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | Access Key | `string` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Credrails Devops Challenge | `string` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | AWS profile | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region. | `string` | n/a | yes |
| <a name="input_db_region"></a> [db\_region](#input\_db\_region) | AWS DB Region. | `string` | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Secret Access Key | `string` | n/a | yes |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | n/a | `string` | `""` | no |
| <a name="input_app"></a> [app](#input\_app) | Application instance name (). | `string` | `"credrails-devops-challenge"` | no |
| <a name="input_app_stage"></a> [app\_stage](#input\_app\_stage) | Application stage (ie. dev, prod, qa, etc). | `string` | `"dev"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | n/a | `string` | `""` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | n/a | `string` | `""` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | n/a | `string` | `""` | no |
| <a name="input_global_tags"></a> [global\_tags](#input\_global\_tags) | n/a | `map(string)` | <pre>{<br>  "Owner": "edward buba",<br>  "Provisioner": "Terraform"<br>}</pre> | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | n/a | `string` | `""` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | n/a | `string` | `""` | no |
| <a name="input_username"></a> [username](#input\_username) | n/a | `string` | `""` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_prefix"></a> [app\_prefix](#output\_app\_prefix) | n/a |
| <a name="output_cluster-ca-cert"></a> [cluster-ca-cert](#output\_cluster-ca-cert) | n/a |
| <a name="output_cluster-token"></a> [cluster-token](#output\_cluster-token) | n/a |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for EKS control plane. |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | EKS cluster ID. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Kubernetes Cluster Name |
| <a name="output_config_map_aws_auth"></a> [config\_map\_aws\_auth](#output\_config\_map\_aws\_auth) | A kubernetes configuration to authenticate to this EKS cluster. |
| <a name="output_db_endpoint"></a> [db\_endpoint](#output\_db\_endpoint) | RDS |
| <a name="output_nginx_kubectl_config"></a> [nginx\_kubectl\_config](#output\_nginx\_kubectl\_config) | kubectl config as generated by the module. |
| <a name="output_private-subnets"></a> [private-subnets](#output\_private-subnets) | n/a |
| <a name="output_public-subnet"></a> [public-subnet](#output\_public-subnet) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->