locals {
  name_prefix   = "${var.app_name}-${var.app}"
  account_id    = data.aws_caller_identity.current.account_id
  account_alias = data.aws_iam_account_alias.current.account_alias
  cluster_name      = "${var.app_name}-${random_string.suffix.result}"
  instance-userdata = <<EOF
    #!/bin/bash
  EOF

  asg_names = data.aws_autoscaling_groups.groups.names
}

variable "aws_region" {
  type        = string
  description = "AWS Region."
  //  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "AWS profile"
  type        = string
}

variable "app_name" {
  type        = string
  description = "Credrails Devops Challenge"
}

variable "app" {
  type        = string
  description = "Application instance name ()."
  default     = "credrails-devops-challenge"
}

variable "app_stage" {
  type        = string
  description = "Application stage (ie. dev, prod, qa, etc)."
  default     = "dev"
}

variable "global_tags" {
  type = map(string)

  default = {
    Provisioner = "Terraform"
    Owner       = "edward buba"
  }
}

variable "access_key" {
  type        = string
  description = "Access Key"

}

variable "secret_key" {
  type        = string
  description = "Secret Access Key"
}
