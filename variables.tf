###############VPC/network-variables##################
variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "webservice_subnet_cidr_block" {
  type = string
  default = "10.0.0.0/24"
}

variable "webservice_subnet_az" {
  type = string
  default = "us-east-2a"
}

variable "db_subnet_cidr_block" {
  type = string
  default = "10.0.1.0/24"
}

variable "db_subnet_az" {
  type = string
  default = "us-east-2a"
}

variable "webservice_nic" {
  type = string
  default = "10.0.0.100"
}

variable "db_nic" {
  type = string
  default = "10.0.1.100"
}

variable "webservice_sg_name" {
  type = string
  default = "web-sg"
}

variable "webservice_sg_description" {
  type = string
  default = "Allow HTTP, HTTPS, SSH"
}

variable "db_sg_name" {
  type = string
  default = "db-sg"
}

variable "db_sg_description" {
  type = string
  default = "Allow Private network"
}

variable "webservice_rt_cidr_block" {
  type = string
  default = "0.0.0.0/0"
}

variable "db_rt_cidr_block" {
  type = string
  default = "0.0.0.0/0"
}


###############EC2-variables##################

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "ssh_pub" {
  type= string
  default = ("C:\\Users\\aren\\.ssh\\id_rsa.pub")
}

variable "private_key" {
  default = ("C:\\Users\\aren\\.ssh\\id_rsa")
}

/* variable "connection_type" {
  type= string
  default = "ssh"
}

variable "connection_user" {
  type= string
  default = "ec2-user"
}

variable "ec2_keypair_name" {
  type= string
  default = "webserver-key"
} */

###############APIGW-variables##################

variable "apigw_rest_api_description" {
  type = string
  default = "weather"
}

variable "apigw_rest_api_name" {
  type = string
  default = "weather"
}

variable "apigw_rest_api_stage_name" {
  type = string
  default = "weather"
}

variable "xray_tracing_enabled" {
  type = bool
  default = false
}

variable "method_authorization" {
  type = string
  default = "NONE"
}

variable "http_method" {
  type = string
  default = "GET"
}

variable "method_response_status_code" {
  type = string
  default = "200"
}

variable "integration_connection_type" {
  type = string
  default = "INTERNET"
}

variable "integration_connection_handling" {
  type = string
  default = "CONVERT_TO_TEXT"
}

variable "integration_http_method" {
  type = string
  default = "POST"
}

variable "integration_passthrough_behavior" {
  type = string
  default = "WHEN_NO_MATCH"
}

variable "integration_type" {
  type = string
  default = "AWS_PROXY"
}

###############ELB-variables##################

variable "elb_name" {
  type = string
  default = "kirills-demo-terraform-elb"
}

###############DNS-variables##################

variable "route53_zone_name" {
  type = string
  default = "aren.page."
}

variable "route53_record_name" {
  type = string
  default = "terraform.aren.page"
}

variable "route53_record_type" {
  type = string
  default = "CNAME"
}

variable "cert_common_name" {
  type = string
  default = "terraform.aren.page"
}

###############TLS-variables##################

variable "tls_private_key_algorithm" {
  type = string
  default = "RSA"
}

variable "acme_registration_email" {
  type = string
  default = "harutyunyanaren5@gmail.com"
}

variable "acme_cert_challange_provider" {
  type = string
  default = "route53"
}

###############Lambda-variables##################

variable "lambda_iam_role_name" {
  type = string
  default = "weather_Lambda_Function_Role"
}

variable "lambda_iam_policy_name" {
  type = string
  default = "aws_iam_policy_for_terraform_aws_weather_lambda_role"
}

variable "lambda_zip_filename" {
  type = string
  default = "weather.zip"
}

variable "lambda_fuction_name" {
  type = string
  default = "weather"
}

variable "lambda_fuction_handler" {
  type = string
  default = "index.handler"
}

variable "lambda_fuction_runtime" {
  type = string
  default = "nodejs14.x"
}