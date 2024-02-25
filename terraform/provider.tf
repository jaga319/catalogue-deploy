terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0" # AWS provider version, not terraform version
    }
  }
     backend "local" {}
}


provider "aws" {
  region = "us-east-1"
}