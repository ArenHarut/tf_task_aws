resource "aws_elb" "webservice" {
  name = "kirills-demo-terraform-elb"
  /* availability_zones = ["us-east-2a"] */
  security_groups = ["${aws_security_group.webserver_sg.id}"]
  subnets         = ["${aws_subnet.webservice.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = aws_acm_certificate.Kirills.arn
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = [aws_instance.web.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "kirills-demo-terraform-elb"
  }
}