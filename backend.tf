terraform {
  backend "s3" {
    shared_credentials_file = "/home/mani/mani_creds"
    bucket = "accesslogs77"
    key    = "terraform-backend/mani.tfstate"
    region = "ap-south-1"
    profile = "mani"
  }
}