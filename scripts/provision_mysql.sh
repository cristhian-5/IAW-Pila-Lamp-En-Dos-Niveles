#!/bin/bash

# 1. Actualiza los repositorios y instala MariaDB Server y Git
apt-get update -y
apt-get install -y mariadb-server git

# 2. Configura MariaDB para que escuche en todas las interfaces, red privada
sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb

# 3. Descarga el repositorio de la aplicación para tener el script de la BD
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /tmp/iaw-practica-lamp

# 4. Crea la base de datos y importa las tablas
mysql -u root -e "CREATE DATABASE IF NOT EXISTS lamp_db CHARSET utf8mb4;"
mysql -u root lamp_db < /tmp/iaw-practica-lamp/db/database.sql

# 5. Crea un usuario con permisos remotos SOLO desde la máquina Apache (192.168.56.10)
mysql -u root -e "CREATE USER IF NOT EXISTS 'lamp_user'@'192.168.56.10' IDENTIFIED BY 'lamp_password';"
mysql -u root -e "GRANT ALL PRIVILEGES ON lamp_db.* TO 'lamp_user'@'192.168.56.10';"
mysql -u root -e "FLUSH PRIVILEGES;"

# 6. Limpia archivos temporales
rm -rf /tmp/iaw-practica-lamp

# 7. corta el acceso a internet o elimina la ruta por defecto de la interfaz NAT eth0
ip route del default