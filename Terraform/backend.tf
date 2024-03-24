terraform {
  backend "s3" {
    bucket  = ********
    encrypt = true
    key     = ********
    region  = "us-east-1"
  }
}
