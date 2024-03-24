
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.32.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "dartsly-infrastructure-terraform-state"
    key            = "dartsly-infrastructure-terraform-state"
    region         = "eu-central-1"
    dynamodb_table = "dartsly-infrastructure-terraform-lock"
    encrypt        = true
  }
}

provider "cloudflare" {
  email     = "bendt@schulz-hamburg.de"
  api_token = var.cloudflare_token
}

provider "aws" {
  region = "eu-central-1"
}

module "backend_setup" {
  source            = "./tf-backend-setup"
  state_bucket_name = "dartsly-infrastructure-terraform-state"
  lock_table_name   = "dartsly-infrastructure-terraform-lock"
}
