#!/bin/bash													#sha-Bang

if [ -e /var/www/html/index.html ]; then					#checks frontpage for httpd service installed
	exit 0;													#exits on positive confirmation of service 
fi															#closes condition

yum -y install httpd mod_ssl								#installs httpd service with ssl
systemctl enable httpd										#enables service
systemctl start httpd										#starts service

sed -i 's/^/#/g' /etc/httpd/conf.d/welcome.conf				#suppress default frontpage

/usr/bin/cat <<EOF > /var/www/html/index.html				#path to custom frontpage
<html><body> /n<h1>NTI-300</h1> /n<h2>Automatizing Linux</h2> /n<p>Because We Can!</p> /n</body></html>
EOF															#EndOfFile marker

/usr/bin/cat <<EOF > /var/spool/cron/root
# ┌───────────── minute (0 - 59)
# │ ┌───────────── hour (0 - 23)
# │ │ ┌───────────── day of month (1 - 31)
# │ │ │ ┌───────────── month (1 - 12)
# │ │ │ │ ┌───────────── day of week (0 - 6) (Sunday to Saturday;
# │ │ │ │ │                                       7 is also Sunday on some systems)
# │ │ │ │ │
# │ │ │ │ │
# * * * * *  command to execute
59,11 * * * /usr/bin/echo "HELLO WORLD!"					#11:59 crontab echoes "Hello World!"
00,0 * * * /home/slipknotts/GitHub/NTI300/autoPage.sh		#Midnight crontab updates autoPage.sh
EOF															#EndOfFile Marker

mkdir -p /home/slipknotts/GitHub/NTI300/					#creates directories for autoPage.sh file
/usr/bin/cat <<EOF > /home/slipknotts/GitHub/NTI3000/autoPage.sh

#!/bin/bash													#second sha-Bang
echo -e "<html><body> /n<h1>NTI-300</h1> /n<h2>Automatizing Linux</h2> /n<p>Current System TimeStamp  ...  $(date +%c)</p> /n</body></html>" > /var/www/html/index.html				   #updates time on page
EOF															#EndOfFile Marker
