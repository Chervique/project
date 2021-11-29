#!/bin/bash
sudo yum update -y

sudo yum install awscli -y
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo chmod -R 755 /var/www/html
sudo yum install php php7.4-fpm -y

sudo aws s3 cp s3://atymhw4/index.php /var/www/html/index.php
sudo aws s3 cp s3://atymhw4/default /etc/nginx/sites-available/default
sudo aws s3 cp s3://atymhw4/self-signed.conf /etc/nginx/snippets/
sudo aws s3 cp s3://atymhw4/ssl-params.conf /etc/nginx/snippets/
sudo aws s3 cp s3://atymhw4/atym.pem /etc/ssl/
sudo aws s3 cp s3://atymhw4/atym.key /etc/ssl/ 

sudo rm /var/www/html/index.nginx-debian.html
sudo yum install mariadb-server php-mysql -y

sudo DEBIAN_FRONTEND=noninteractive yum install phpmyadmin php-mbstring -y
sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
sudo chmod 775 -R /usr/share/phpmyadmin/
sudo chmod -R 755 /var/www/html
sudo chown -R www-data:www-data /usr/share/phpmyadmin




sudo systemctl restart nginx
#sudo yum upgrade -y
