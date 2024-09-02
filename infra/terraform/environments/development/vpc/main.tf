locals {
    cluster_name = ""
}

####
# EKS Vpc
####

module "vpc" {
    #   might move to a sperate git repo: source  = "git::https://github.com/your-org/terraform-vpc.git?ref=v1.0.0"
    source = "../../../modules/vpc"
    region = var.region
    cidr_block = var.cidr_block
}