terraform {
  backend "s3" {
    bucket = "accesslogs77"
    key    = "terraform-backend/mani.tfstate"
    region = "ap-south-1"
  }
}