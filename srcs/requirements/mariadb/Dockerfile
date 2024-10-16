FROM debian:buster

RUN apt update -y
RUN apt upgrade -y
RUN apt install vim -y
RUN apt-get install mariadb-server -y
RUN apt-get install -y procps

COPY conf/fichier.cnf	/etc/mysql/mariadb.conf.d/fichier.cnf
COPY ./tools/init_mysql.sh /app/init_mysql.sh
RUN chmod +x /app/init_mysql.sh

EXPOSE 3306

ENTRYPOINT ["sh", "-c", "/app/init_mysql.sh"]

#1- base de l'image Docker,
#3- Met à jour la liste des paquets disponibles, Y repond oui
#4- Met à jour tous les paquets installés
#5- installe  vim Y repond oui, pour du developement ou debogage, pas utile.
#6- installe le serveur MariaDB dans le conteneur Docker.
#7- Installe le paquet procps = top;affiche info processus en cours, info systeme
#8- fichier = fichier est utilisé pour configurer MariaDB.
#9- init = Ce script est destiné à initialiser ou configurer MariaDB lorsqu'il est exécuté.
#11- permet au script d'être exécuté
#12- conteneur écoute sur le port 3306. les connexions des clients à la base de données.port par défaut pour les connexions MariaDB/MySQL.
#15- Définit le script init_mysql.sh comme la commande à exécuter lorsque le conteneur démarre.

