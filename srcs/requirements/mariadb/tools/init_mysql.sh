#!/bin/bash

cp /usr/share/mysql/mysql.server /usr/local/bin
chmod +x /usr/local/bin/mysql.server
chown -R mysql:mysql /var/lib/mysql

mysqld_safe --skip-grant-tables &
sleep 5

mysql -u root << EOF
UPDATE mysql.user SET authentication_string = PASSWORD('${SQL_ROOT_PASSWORD}') WHERE User = 'root';
FLUSH PRIVILEGES;
EOF

mysqladmin shutdown -uroot --password="${SQL_ROOT_PASSWORD}"

mysqld_safe &
sleep 5

mysql -uroot -p"${SQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
FLUSH PRIVILEGES;
EOF

mysqladmin shutdown -uroot --password="${SQL_ROOT_PASSWORD}"

exec mysqld_safe

#1- est une ligne de shebang pour executer avec bash
#init_mysql.sh  = change mot de passe root et creer un utilisateur pour accder a notre base de donne et crrer une nouvelle base de donne pour wordpress

#script avec Ces commandes permettent de préparer, configurer, et sécuriser le serveur MariaDB dans un conteneur Docker, en gérant les privilèges, en configurant les utilisateurs et les bases de données, et en assurant que le serveur fonctionne correctement avec les paramètres appropriés. initialiser et configurer le serveur en utilisant les valeurs .env

#3- copie dans le conteneur le script qui demarre et arrete le serveur mariadb/
#4- Change les permissions du fichier pour que MariaDB ait les permissions nécessaires et rend le script mysql.server exécutable, ce qui permet de le lancer comme une commande.
#5-change la propriété du répertoire mysql et de tous ses fichiers pour qu'ils appartiennent à l'utilisateur et au groupe mysql, garantissant que MariaDB peut accéder à ses fichiers de données.

#7- sript démarre le serveur de manière sécurisée, sans vérifier les tables de privilèges, contourner les vérifications de mot de passe
#Le caractère & permet d'exécuter mysqld_safe en arrière-plan pour continuer dutiiser le terminal
#8- Donne suffisamment de temps au serveur MariaDB/MySQL pour démarrer
#10- se connecter a mysql en root
#EOF grouper plusieurs instructions SQL et garantir qu'elles sont exécutées correctement. -u speccifie lutisateur root
#11- Réinitialise le mot de passe root.dans la table des utilisateurs de MariaDB/MySQL.
#12- Assure que les modifications de privilèges sont prises en compte immédiatement.

#15- arrete le serveur proprement avec le mot de passe pour garantir que toutes les modifications sont appliquées

#17- mysqldsafe = script qui demare le serveur de bdd en securise 
#20- se cnnecte au setrveur mariadb, en root avec  inclut le mot de passe base de donnee
#20- creer la base de donnee sil elle existe pas
#22- cree un utilisateur sil nexiste pas avec un mot de passe specifique et possibilite de localhost
#23- donne tous les privilege  a luitlisateur identifie par son mot de passe sur la bse de donnee
#24- assure que les mofification privilege on ete pris en compte

#27- (mysgldadmin outil de gestion) redemare le serveur avec les nouvelles configurations base de donnee
#28- démarre le serveur MySQL/MariaDB en mode sécurisé et remplace le processus en cours par celui du serveur, garantissant une exécution sécurisée et stable.





