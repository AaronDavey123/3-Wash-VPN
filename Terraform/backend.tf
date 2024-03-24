terraform {
  backend "s3" {
    bucket  = "hambro-3-tier-aws"
    encrypt = true
    key     = "terraform.ftstate"
    region  = "us-east-1"
  }
}