terraform  {
  backend "s3" {
    bucket = "terraform-neilrichards-up-and-run"
    key = "prod/services/webserver-cluster/terraform.tfstate"
    region = "eu-west-2"
    encrypt = true
  }
}


provider "aws" {
  region = "eu-west-2"
}

module "webserver-cluster" {
  source = "../../../modules/services/webserver-cluster"
  cluster_name = "webservers-prod"
  db_remote_state_bucket = "terraform-neilrichards-up-and-run"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"
  instance_type = "t2.micro"
  min_size = 2
  max_size = 2
}

//Demonstrate using output values from module
resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  autoscaling_group_name = "${module.webserver-cluster.asg_name}"
  scheduled_action_name = "scale-out-during-business-hours"
  min_size = 2
  max_size = 10
  desired_capacity = 10
  recurrence = "0 9 * * *"
}

//Demonstrate using output values from module
resource "aws_autoscaling_schedule" "scale_in_at_night" {
  autoscaling_group_name = "${module.webserver-cluster.asg_name}"
  scheduled_action_name = "scale-in-at-night"
  min_size = 2
  max_size = 10
  desired_capacity = 2
  recurrence = "0 17 * * *"
}



