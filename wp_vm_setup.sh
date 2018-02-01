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
mysql -u root -p < /home/admin/4640scripts/mariadb_security_config.sql
mysql -u root -p < /home/admin/4640scripts/wp_mariadb_config.sql


#install php
yum install php php-mysql php-fpm -y
cp -u /home/admin/4640scripts/php.ini /etc/php.ini
cp -u /home/admin/4640scripts/www.conf /etc/php-fpm.d/www.conf
systemctl enable php-fpm
systemctl start php-fpm
cp /home/admin/4640scripts/nginx.conf /etc/nginx/nginx.conf
cp /home/admin/4640scripts/info.php /usr/share/nginx/html/info.php
systemctl restart nginx

#install wordpress
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp /home/admin/4640scripts/wp-config.php wordpress/wp-config.php
rsync -avP wordpress/ /usr/share/nginx/html/
chown -R admin:nginx /usr/share/nginx/html/*




