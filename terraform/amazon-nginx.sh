#!/bin/bash
sudo yum update -y

sudo amazon-linux-extras install nginx1 -y
sudo amazon-linux-extras enable php7.4
sudo yum clean metadata
sudo yum install php php-cli php-mysqlnd php-pdo php-common php-fpm -y
sudo yum install php-gd php-mbstring php-xml php-dom php-intl php-simplexml -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl start php-fpm
sudo systemctl enable php-fpm


sudo aws s3 cp s3://atymhw4/index.php /var/www/html/index.php
sudo aws s3 cp s3://atymhw4/default.conf /etc/nginx/conf.d/default.conf
sudo aws s3 cp s3://atymhw4/www.conf /etc/php-fpm.d/www.conf
sudo aws s3 cp s3://atymhw4/self-signed.conf /etc/nginx/snippets/
sudo aws s3 cp s3://atymhw4/ssl-params.conf /etc/nginx/snippets/
sudo aws s3 cp s3://atymhw4/atym.pem /etc/ssl/
sudo aws s3 cp s3://atymhw4/atym.key /etc/ssl/ 

## Add NGINX and PHP-FPM service start to boot sequence
$ sudo chkconfig nginx on
$ sudo chkconfig php-fpm on

## Start NGINX and PHP-FPM service
$ sudo service nginx start
$ sudo service php-fpm start

sudo chmod -R 755 /var/www/html
sudo rm /var/www/html/index.nginx-debian.html



sudo systemctl restart nginx
#sudo yum upgrade -y