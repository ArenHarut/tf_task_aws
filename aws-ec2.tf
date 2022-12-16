resource "aws_instance" "web" {
  ami           = data.aws_ami.webserver.id
  instance_type = var.instance_type
  key_name = aws_key_pair.webserver-key.key_name
  network_interface {
    network_interface_id = aws_network_interface.webservice.id
    device_index         = 0
  }
  connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key)
      host        = aws_instance.web.public_ip
    }
  provisioner "file" {
    source = "./scripts/webserver.sh"
    destination = "/home/ec2-user/webserver.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x webserver.sh"
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "/home/ec2-user/webserver.sh"
    ]
  }
  provisioner "file" {
    source = "scripts/ping.sh"
    destination = "/home/ec2-user/ping.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x ping.sh"
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "/home/ec2-user/ping.sh"
    ]
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
  
  tags = {
    Name = "DemoForKirills"
  }
  depends_on = [
    aws_instance.db
  ]
}

resource "aws_instance" "db" {
  ami           = data.aws_ami.webserver.id
  instance_type = var.instance_type
  key_name = aws_key_pair.webserver-key.key_name
  network_interface {
    network_interface_id = aws_network_interface.db.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
  user_data = "${file("./scripts/init.sh")}"
  tags = {
    Name = "DemoForKirills"
  }
}

resource "aws_key_pair" "webserver-key" {
  key_name   = "webserver-key"
  public_key = file(var.ssh_pub)
}

