#!/bin/bash

if [ -e /etc/httpd ]; then                            #checks if httpd exists  
  exit 0;                                             #exits on existence of service
fi                                                    #closes if statement 

yum -y install httpd mod_ssl                          #installs apache with ssl 
systemctl enable httpd                                #enables apache
systemctl start httpd                                 #starts apache

sed -i 's/^/#/g' /etc/httpd/conf.d/welcome.conf       #comment out default index page

echo -e "<html><body> /n<h1>NTI-300</h1> /n<h2>Automatizing and Scriptivating with Linux</h2> /n</body></html> > /var/www/html/index.html

systemctl restart httpd                               #restarts apache service so changes take effect
