#!/bin/bash
#Esto es el código de instalación de todos los sistemas que necesitamos.

set -x #esto muestra los comandos que se están ejecutando

#actualizamos los repositorios
sudo apt update

#Actualizamos los paquetes
sudo apt upgrade -y #"-y" Es para responder que si automáticamente a la pregunta de confirmación.

#Instalamos el servidor web Apache
sudo apt install apache2 -y

#Instalamos el sistema gestor de bases de datos MySQL
sudo apt install mysql-server -y

#Instalamos php

sudo apt install php libapache2-mod-php php-mysql -y

#Con esto aplicamos los ajustes que hemos escrito en el archivo conf/default.conf
#Estos ajustes son para que nuestro servidor se pueda conectar con la página web.
sudo cp ../conf/000-default.conf /etc/apache2/sites-available

#Reiniciamos el servidor para aplicar los cambios
sudo systemctl restart apache2

#Copiamos el archivo de prueba de PHP
sudo cp ../php/index.php /var/www/html

#Modificamos el propietario y el grupo del directorio /var/www/html para
#que la persona que abra esta página desde la web tenga permisos.
#El comando "-R" para hacer los cambios de forma recursiva.
sudo chown -R www-data:www-data /var/www/html



#### NO ME FUNCIONA COMO DEBE; PREGUNTAR AL PROFESOR (El problema es que al poner la ip del server
#en google no me muestra lo que me debe mostrar.)