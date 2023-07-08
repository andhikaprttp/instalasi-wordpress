#!/bin/bash

# Konfigurasi MySQL
db_root_password="kata_sandi_root_mysql"
db_name="nama_database_wordpress"
db_user="nama_pengguna_wordpress"
db_password="kata_sandi_wordpress"

# Konfigurasi SSH
new_username="pengguna_baru"
new_password="kata_sandi_baru"

# 11 TKJ 1 | SMK RADEN PAKU
echo "#############################"
echo "==== INSTALASI WORDPRESS ===="
echo "#############################"
echo "| XI TKJ 1 | SMK RADEN PAKU |"
echo "============================="

# Instalasi MySQL
echo "===== Instalasi MySQL ====="
sudo apt-get update
sudo apt-get install mysql-server -y
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${db_root_password}';"

# Instalasi PHP dan Apache
echo "===== Instalasi PHP dan Apache ====="
sudo apt-get install php libapache2-mod-php php-mysql -y
sudo systemctl restart apache2

# Instalasi WordPress
echo "===== Instalasi WordPress ====="
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
sudo mv wordpress /var/www/html/
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress
sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
sudo sed -i "s/database_name_here/${db_name}/" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/username_here/${db_user}/" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/password_here/${db_password}/" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.4/apache2/php.ini
sudo systemctl restart apache2

# Konfigurasi SSH
echo "===== Konfigurasi SSH ====="
sudo adduser ${new_username}
echo -e "${new_password}\n${new_password}" | sudo passwd ${new_username}

# Menampilkan informasi SSH
echo "===== Informasi SSH ====="
echo "Anda dapat mengakses Ubuntu server dengan menggunakan SSH."
echo "Gunakan perintah berikut:"
echo "ssh ${new_username}@alamat_ip_server"

# Selesai
echo "===== Selesai ====="
