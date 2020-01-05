#!/bin/bash
#see https://www.digitalocean.com/community/tutorials/how-toserve-djanga-applications-with-apache-and-mod_wsgi-on-centos-7
yum -y install httpd mod_wsgi  #BEFORE migrate
echo 'STATIC_ROOT = os.path.join(BASE_DIR, "static/")' >> /opt/django/project1/project1/settings.py  #BEFORE migrate

source /opt/django/django-env/bin/activate
/opt/django/project1/manage.py collectstatic

#written into file: /etc/httpd/conf.d/django.conf

echo "Alias /static /opt/django/project1/static/
<Directory /opt/django/project1/static/>
  Require all granted
</Directory>
<Directory /opt/django/project1/project1>
  <Files wsgi.py>
    Require all granted
  </Files>
</Directory>
  