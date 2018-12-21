
terraform  {
  backend "s3" {
    bucket = "terraform-neilrichards-up-and-run"
    key = "prod/data-stores/mysql/terraform.tfstate"
    region = "eu-west-2"
    encrypt = true
  }
}



provider "aws" {
  region = "eu-west-2"
}

module "mysql" {
  source = "../../../modules/data-stores/mysql"

  db_name = "mysqlprod"
  //Ignore this passing in password in plain text for now
  db_password = "passwordprod123"
}

//Added to proxy the values into the tfstate file for access by the webcluster module
output "address" {
  value = "${module.mysql.address}"
}

output "port" {
  value = "${module.mysql.port}"
}

