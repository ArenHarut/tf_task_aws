#!/bin/bash
sudo su <<EOF
yum -y install httpd mod_ssl && systemctl start httpd
cd /var/www/html
echo '<h1><center>My First webpage that I deployed with Terraform</center></h1><h1><center>To browser to second page, go to /page.html</center></h1>' > index.html
echo '<h1><center>My Second webpage that I deployed with Terraform</center></h1>' > page.html
EOF