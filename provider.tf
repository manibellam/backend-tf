terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.63.0"
    }
  }
}

provider "aws" {
  # Configuration options
region = "ap-southeast-1"
profile = "mani"
}

