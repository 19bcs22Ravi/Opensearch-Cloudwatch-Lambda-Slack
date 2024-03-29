terraform {
  backend "s3" {
    bucket         = "systlabs"
    key            = "Ravi/terraform.tfstate"
    region         = "ap-south-1"
  }
}
