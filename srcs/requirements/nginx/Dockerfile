FROM debian:buster

RUN apt update -y
RUN apt upgrade -y
RUN apt install nginx -y
RUN apt install vim -y
RUN apt install curl -y
RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl -y
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=afromont.42.fr/UID=afromont"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD [ "nginx", "-g", "daemon off;" ]


#curl pour requette http

#3- Met à jour la liste des paquets disponibles, Y repond oui
#4- Met à jour tous les paquets installés
#6- installe  vim Y repond oui, pour du developement ou debogage, pas utile.
#7- curl - outil en ligne de commande - Affiche le contenu de la page web à l'URL fournie
#8- Chemin du répertoire à créer, ici pour stocker les fichiers SSL pour Nginx, dans le conteneur Docker  -p (creer repertoire parents si necessaire)
#9- OpenSSL offre des outils pour examiner et vérifier les certificats et les clés(openssl verify certificat.crt, verifie si le certificat est valide et correctement signe par un autorite de certification)
#10- Génère un certificat SSL auto-signé et une clé privée./Nécessaire pour sécuriser les connexions HTTPS vers le serveur Nginx. requete de signature, 
#12- Utilisé par Nginx pour stocker les fichiers de PID (Process ID) (numéro unique attribué à chaque processus en cours d'exécution sur un système d'exploitation, top)
#14-  copie le fichier de configuration Nginx depuis l'hôte vers le répertoire de configuration d'Nginx dans l'image Docker.

#16- ecriture que pour le propritaire, répertoire où vous placez les fichiers que vous souhaitez rendre accessibles via votre serveur web.
#17- change le propietaire, assurant ainsi que le serveur web peut accéder et manipuler ces fichiers correctement tout en maintenant la sécurité du système. nécessaires pour servir le contenu web.
#contient tous les fichiers nécessaires au fonctionnement de votre site web, servant de racine pour le serveur web qui les rend accessibles via le navigateur. 

#19- commande qui spécifie comment démarrer le serveur Nginx lorsque le conteneur est lancé
#-g : Permet de passer des configurations spécifiques à Nginx. 
#processus en arrière-plan qui effectue des tâches ou fournit des services sans interaction directe avec l'utilisateur. 
# Configure Nginx pour rester en premier plan, ce qui est essentiel pour que Docker puisse gérer correctement le conteneur et surveiller les logs.( enregistrements des activités et erreurs générées par des système,  pour la sécurité des systèmes informatiques, pour surveiller le trafic web.) 


