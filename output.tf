output "first_web_page" {
  value = "https://${aws_route53_record.test.name}"
}

output "second_web_page" {
  value = "https://${aws_route53_record.test.name}/page.html"
}