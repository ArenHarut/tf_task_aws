data "aws_route53_zone" "dnsfordemo" {
  name         = var.route53_zone_name
}

resource "aws_route53_record" "test" {
  zone_id = data.aws_route53_zone.dnsfordemo.zone_id
  name    = var.route53_record_name
  type    = var.route53_record_type
  ttl     = 60
  records = [aws_elb.webservice.dns_name]
}

resource "tls_private_key" "private_key" {
  algorithm = var.tls_private_key_algorithm
}

resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.acme_registration_email # TODO put your own email in here!
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.registration.account_key_pem
  common_name               = var.cert_common_name
  subject_alternative_names = ["${data.aws_route53_zone.dnsfordemo.name}"]

  dns_challenge {
    provider = var.acme_cert_challange_provider

    config = {
      AWS_HOSTED_ZONE_ID = data.aws_route53_zone.dnsfordemo.zone_id
    }
  }

  depends_on = [acme_registration.registration]
}

resource "aws_acm_certificate" "Kirills" {
  certificate_body  = acme_certificate.certificate.certificate_pem
  private_key       = acme_certificate.certificate.private_key_pem
  certificate_chain = acme_certificate.certificate.issuer_pem
}