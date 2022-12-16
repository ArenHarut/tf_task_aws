output "base_url" {
  value = "${aws_api_gateway_deployment.weather.invoke_url}weather?city=London&date=2022-12-16"
}

output "first_web_page" {
  value = "https://${aws_route53_record.test.name}"
}

output "second_web_page" {
  value = "https://${aws_route53_record.test.name}/page.html"
}