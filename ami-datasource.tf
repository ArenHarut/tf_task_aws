data "aws_ami" "webserver" {

  filter {
    name   = "name"
    values = ["RHEL-9.1.0_HVM-20221101-x86_64-2-Hourly2-GP2"]
  }

  owners = ["309956199498"] 
}