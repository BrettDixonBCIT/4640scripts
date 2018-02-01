#Install First set of packages
yum install @core epel-release vim git tcpdump nmap-ncat curl wget -y

#Setup Firewall
firewall-cmd --zone=public --add-port=22/tcp --permanent
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
systemctl restart firewalld

#install nginx
yum install nginx -y
systemctl enable nginx
systemctl start nginx

#install mariadb
yum install mariadb-server mariadb -y
systemctl enable mariadb
systemctl start mariadb

#install php
yum install php php-mysql php-fpm -y
systemctl enable php-fpm
systemctl start php-fpm



