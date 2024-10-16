FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y wget vim curl mariadb-client

# Ajoutez ces lignes pour installer les dépôts supplémentaires
RUN apt-get install -y lsb-release apt-transport-https ca-certificates
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update

# Installez PHP 7.4 et ses extensions
RUN apt-get install -y php7.4 php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd php7.4-intl php7.4-mbstring php7.4-soap php7.4-xml php7.4-zip

RUN wget https://fr.wordpress.org/latest-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf latest-fr_FR.tar.gz && rm latest-fr_FR.tar.gz
RUN chown -R root:root /var/www/wordpress

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod 777 /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/auto_config.sh /app/auto_config.sh
RUN chmod +x /app/auto_config.sh 

ENTRYPOINT ["sh", "-c", "/app/auto_config.sh"]

# auto-config.sh : Automatise la configuration des paramètres lors du démarrage.
# www.conf : Configure les paramètres de PHP-FPM pour gérer les processus PHP et la communication avec le serveur web.
#1	: Utilise debian buster en image de base
#3-7 	: Met a jour les paquets et installe wget,vim,curl
#8-11 	: Installe php et les modules necessaires (php-fpm, php-mysql, client mariadb) pour gerer les processus
#13-15	: Installe wordpress 6.0 en francais, extrait les fichiers dans /var/www et supprime 
#	: l'archive compressee. utilise "chown" pour que les fichiers soient accessibles par le root
#16	: s'assure que php est bien installe (pas necessaire, c'est une securite)
#19-20	: On met notre fichier perso de php-fpm dans le conteneur, et on change les permissions
#	: pour un acces total (lecture, ecriture, execution)
#22	: cree le dossier php pour stocker les fichiers PID et sockets utilises par php-fpm(gere les procesus)
#24-26	: Installe WP-CLI (outil en ligne de commandes pour gerer le wordpress), on donne les 
#	: permissions d'execution et met l'executable (le programme) sur le pc pour qu'il soit
#	: utilisable globalement avec la commande "wp"
#28-29	: Copie notre script perso auto_config dans le conteneur, il permettra de configurer le
#	: wordpress automatiquement
#31	: Point d'entree du conteneur, on execute autoconfig
