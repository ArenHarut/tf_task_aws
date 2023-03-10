terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.46.0"
    }
    acme = {
      source  = "vancluever/acme"
      version = "2.11.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

provider "acme" {
  #server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

terraform {
  backend "s3" {
    bucket = "backend-tf-demo"
    key    = "kirills/terraform.tfstate"
    region = "us-east-2"
  }
}