terraform {
  backend "s3" {
    bucket = "terraform-neilrichards-up-and-run"
    key="global/s3/terraform.tfstate"
    region = "eu-west-2"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-neilrichards-up-and-run"


  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

}

