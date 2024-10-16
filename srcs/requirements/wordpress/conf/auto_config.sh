#!/bin/bash

sleep 15

if test ! -f /var/www/wordpress/wp-config.php; then
	mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
fi

wp config set --allow-root --add --path='/var/www/wordpress' DB_NAME $SQL_DATABASE
wp config set --allow-root --add --path='/var/www/wordpress' DB_USER $SQL_USER
wp config set --allow-root --add --path='/var/www/wordpress' DB_PASSWORD $SQL_PASSWORD
wp config set --allow-root --add --path='/var/www/wordpress' DB_HOST mariadb:3306
wp core install --allow-root --path='/var/www/wordpress' --url=https://localhost --title=afromont --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}
wp user create --allow-root --path='/var/www/wordpress' ${WP_USER} ${WP_EMAIL} --user_pass=${WP_PASSWORD}

#wp theme install inspiro --activate --path=/var/www/wordpress --allow-root
mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F


#auto-config.sh : Automatise la configuration des paramètres lors du démarrage.

#1	: Bash
#3	: Sleep de 15 secondes pour permettre aux autres servicex (mariadb) de demarrer
#5-7	: Verifie si le fichier wp-config.php est present. S'il ne l'est pas on renomme le fichier
#	: modele wp-config-sample.php par wp-config (wp-config-sample est un fichier modele au)
#	: cas ou on a pas cree notre propre wp-config
#9-12	: Utilise wp-cli, pour mettre a jour les parametres de la base de donnees dans le fichier
#	: wp-config.php : nom de la base de donnees, nom d'utilisateur pour la connexion, mot de passe
#	: pour l'utilisateur de la base de donnees, adresse et port de la base de donnees
#13	: Insallation de wordpress avec nos parametres : url du site, titre, nom d'utilisateur admin,
#	: mot de passe admin, adresse mail admin
#14	: Creation d'un utilisateur : nom d'utilisateur, email, mot de passe
#15	: Creation repertoir pour stocker si necessaire les sockets et PID utilises par php-fpm
#16	: lance le service php-fpm avec (-F (foreground), lui permet de s'executer en premier plan),
#	: c'est utile dans un conteneur docker, car le processus principal doit rester en cours
#	: d'execution pour que le conteneur ne s'arrete pas.
