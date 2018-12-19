
#Display public-ip without pocking around in AWS console
/*
output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}
*/




//Display DNS name of the ELB
output "elb_dns_name" {
  value = "${aws_elb.example.dns_name}"
}

