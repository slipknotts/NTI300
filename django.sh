#!/bin/bash
yum clean all
yum install -y python-pip
pip install virtualenv
pip install --upgrade pip
mkdir ~/newProject
cd ~/newProject
virtualenv newenv
source newenv/bin/activate
pip install django
django-admin --version
django-admin startproject newProject
cd newProject/
python manage.py migrate
echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@newProject.com', 'NTI300')" | python manage.py shell
myIP=$(curl -s checkip.dyndns.org | sedm -e 's/.*Current IP Address: //' -e 's/<.*$//')
sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \[\'$myIP\'\]/g" newProject/settings.py
python manage.py runserver 0.0.0.0:8000&