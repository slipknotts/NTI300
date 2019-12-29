#!/bin/bash

yum -y install httpd mod_ssl
systemctl enable httpd
systemctl start httpd

sed -i 's/^/#/g' /etc/httpd/conf.d/welcome.conf

echo "<html><body> /n<h1>NTI-300</h1> /n<h2>Automation and Scripting with Linux</h2> /n</body></html>" > /var/www/html/index.html
