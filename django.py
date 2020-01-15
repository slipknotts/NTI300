#!/usr/bin/python

import os
import re
import subprocess

def local_repo():
    repo"''"[local-epel]
name=NTI300 EPEL
baseurl=http://34.67.93.85/epel/
gpgcheck=0
enabled=1"''"
    os.system('for file in $( ls /etc/yum.repos.d/ ); do mv /etc/yum.repos.d/$file /etc/yum.repos.d/$file.bak; done')
    print(repo)
    with open("/etc/yum.repos.d/local-repo.repo","w+") as f:
        f.write(repo)
    f.close()
local_repo()

def setup_install():
    print('installing pip and virtualenv so django has own version of python')
    os.system('yum -y install python-pip && pip install --upgrade pip')
    os.system('pip install virtualenv')
    os.chdir('/opt')
    os.mkdir('/opt/django')
    os.chdir('/opt/django')
    os.system('virtualenv django-env')
    os.system('chown -R slipknotts /opt/django')    #shell works better than builtin python functions
    
def django_install():
    print('activating virtualenv and installing django once pre-reqs ae met')
                                                    #virtualenv must be activated everytime you perfom a command
    os.system('source /opt/django/django-env/bin/activate && pip install django')
                                                    #confirm install then start django project
    os.chdir('/opt/django')
    os.system('source /opt/django/django-env/bin/activate ' + \
              '&& django-admin --version ' + \
              '&& django-admin startproject project1')
    os.system('adduser -M django')
    os.system('usermod -L django')
    os.system('chown -R django /opt/django')
    
def django_start():
    print('starting django')
    os.chdir('/opt/django/project1')
    os.system('source /opt/django/django-env/bin/activate ' + \
              '&& python manage.py migrate')
              
    os.system('source /opt/django/django-env/bin/activate && echo "from django.contrib.auth import get_user_model; User = get_user
    
    outputwithnewline = subprocess.check_output('curl -s checkip.dyndns.org | sed -e \'s/.*Current IP Address: \\/' -e \ 's/<.*$
    print outputwithnewline
    output = outputwithnewline.replace("\n","")
    old_string = "ALLOWED_HOSTS = []"
    new_string = 'ALLOWED_HOSTS = [\'{}\']'.format(output)
    print (new_string)
    print (old_string)
    
    with open('project1/settings.py') as f:
        newText=f.read().replace(old_string, new_string)
        f.close()
    with open('project1/settings.py',"w") as f:
        f.write(newText)
        f.close()
        
        os.system('sudo -u django sh -c "source /opt/django/django-env/bin/activate && python manage.py runserver 0.0.0.0:8000&"')
        
    local_repo()
    setup_install()
    django_install()
    django_start()
    