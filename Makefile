all:
	sudo mkdir -p /home/afromont/data
	sudo mkdir -p /home/afromont/data/wordpress
	sudo mkdir -p /home/afromont/data/database
	sudo mkdir -p /home/afromont/data/mariadb
	sudo chmod 777 /etc/hosts
	sudo chmod 777 /home
	sudo echo "127.0.0.1 afromont.42.fr" >> /etc/hosts
	sudo echo "127.0.0.1 www.afromont.42.fr" >> /etc/hosts
	@docker compose -f ./srcs/docker-compose.yml up -d --build


up:
	@docker compose -f ./srcs/docker-compose.yml up -d

down: 
	sudo docker compose -f srcs/docker-compose.yml down

clean:
	sudo docker compose -f srcs/docker-compose.yml down -v

fclean:
	@docker compose -f ./srcs/docker-compose.yml down
	@docker system prune --volumes --force --all
	sudo rm -rf ~/data

re: fclean all

#CLEAR = sudo docker system prune --force --volumes --all 


#CONS = sudo docker build -t nginx ./srcs/requirements/nginx

#STOP = sudo docker stop $$(docker ps -q)

#LAUNCH = sudo docker run -p 8080:80 -d $$(docker ps -q)

#build:	
#	$(CONS)
#	$(LAUNCH)

#fclean:
#	$(CLEAR)
#	$(VERIF)

#re:
#	$(STOP)
#	$(CLEAR)
#	$(CONST)
