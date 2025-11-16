
-include ./srcs/.env
export

all: build up

build:
	- mkdir -p  $(WORDPRESSVOLUMEPATH) $(MARIADBVOLUMEPATH)
	- docker-compose -f srcs/docker-compose.yml build	

up:
	- docker-compose -f srcs/docker-compose.yml up -d --build

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -a

fclean: clean
	- docker volume rm wordpress mariadb
	- sudo rm -rf $(WORDPRESSVOLUMEPATH)
	- sudo rm -rf $(MARIADBVOLUMEPATH)
	- mkdir -p  $(WORDPRESSVOLUMEPATH) \
				$(MARIADBVOLUMEPATH) \

re: fclean all

.PHONY: all build up down clean fclean