#!/bin/bash

# 1. Actualiza los repositorios y instala Apache, PHP, conector MySQL y Git
apt-get update -y
apt-get install -y apache2 php libapache2-mod-php php-mysql git

# 2. Limpia el directorio web por defecto
rm -rf /var/www/html/*

# 3. Clona la aplicación de ejemplo de GitHub
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /tmp/iaw-practica-lamp

# 4. Mueve el código fuente de la aplicación al directorio raíz de Apache
cp -r /tmp/iaw-practica-lamp/src/* /var/www/html/

# 5. Ajusta el archivo config.php para conectar con el servidor MySQL
sed -i "s/localhost/192.168.56.20/g" /var/www/html/config.php
sed -i "s/database_name_here/lamp_db/g" /var/www/html/config.php
sed -i "s/username_here/lamp_user/g" /var/www/html/config.php
sed -i "s/password_here/lamp_password/g" /var/www/html/config.php

# 6. Ajusta permisos del directorio web y reinicia Apache
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
systemctl restart apache2

# 7. Limpia archivos temporales
rm -rf /tmp/iaw-practica-lamp