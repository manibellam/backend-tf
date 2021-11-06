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
  shared_credentials_file = "/home/mani/mani_creds"
region = "ap-southeast-1"
}
