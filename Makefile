DOCKER_COMPOSE_PATH	=	./srcs/docker-compose.yml

DATA_PATH			= /home/algabrie/data

DB_PATH				= $(DATA_PATH)/db/

WP_PATH				= $(DATA_PATH)/wp/

all:
	@ mkdir -p $(DB_PATH) $(WP_PATH)
	@ grep -qxF '127.0.0.1 algabrie.42.fr' /etc/hosts || echo '127.0.0.1 algabrie.42.fr' >> /etc/hosts
	@ docker-compose -f $(DOCKER_COMPOSE_PATH) up --build

clean: stop
	@ docker system prune -a --force

fclean: clean
	@ rm -rf $(DATA_PATH)

re: fclean all


stop:
	@ docker-compose -f $(DOCKER_COMPOSE_PATH) down


.PHONY: all stop clean fclean re
