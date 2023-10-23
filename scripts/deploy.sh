#!/bin/bash

#Muestra todos los comandos que se van ejecutando
set -x

#Actualizamos los repositorios
apt update

#Actualizamos los paquetes del sistema
sudo apt update

sudo apt upgrade -y

#Incluimos las variables que tenemos en .env
source .env

#Descargamos el repositorio git con el código fuente de la aplicación

#Antes de poder descargarlo tenemos que eliminar el archivo si ya existe, 
#para que no haya errores a la hora de ejecutar el script cuando se ejecuta más de una vez
rm -rf /tmp/iaw-practica-lamp

#Instalamos el repositorio
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /tmp/iaw-practica-lamp

#Movemos todos los archivos del repositorio instalado a /var/www/html
mv /tmp/iaw-practica-lamp/src/* /var/www/html



#Configuramos el archivo config.php de la aplicación
#Estos comandos buscan automáticamente la cadena de la izquierda, como database_name_here
#y Luego los sustituye por las variables de la parte de la derecha.

sed -i "s/database_name_here/$DB_NAME/" /var/www/html/config.php
sed -i "s/username_here/$DB_USER/" /var/www/html/config.php
sed -i "s/password_here/$DB_PASSWORD/" /var/www/html/config.php

#Cambiamos el nombre de la base de datos que vamos a crear importando el archivo de abajo
sed -i "s/lamp_db/$DB_NAME/" /tmp/iaw-practica-lamp/db/database.sql

#Importamos el script de la base de datos
mysql -u root < /tmp/iaw-practica-lamp/db/database.sql

#Creamos el usuario de la base de datos y le asignamos privilegios
mysql -u root <<< "DROP USER IF EXISTS '$DB_USER'@'%'"
mysql -u root <<< "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD'"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%'"