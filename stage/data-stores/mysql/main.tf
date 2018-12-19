terraform {
  backend "s3" {
    bucket = "terraform-neilrichards-up-and-run"
    key="stage/data-stores/mysql/terraform.tfstate"
    region = "eu-west-2"
    encrypt = true
  }
}




provider "aws" {
  region = "eu-west-2"
}

resource "aws_db_instance" "example" {
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  name = "example_database"
  username = "admin"
  password = "${var.db_password}"
}

