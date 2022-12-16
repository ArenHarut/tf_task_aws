#!/bin/bash
sudo yum update -y
sudo yum install wget
wget https://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo yum install mysql-community-release-el7-5.noarch.rpm -y
sudo yum install mysql-server -y
sudo systemctl start mysqld
sudo systemctl enable mysqld
mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE Kirills;
CREATE USER 'kirills'@'%' IDENTIFIED BY '12345';
GRANT ALL ON kirills.* TO kirills@'%' IDENTIFIED BY '12345';
MYSQL_SCRIPT