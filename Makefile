NAME = inception
COMPOSE = docker compose -f docker-compose.yml

all: up

up:
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down --rmi all --remove-orphans

fclean:
	$(COMPOSE) down -v --rmi all --remove-orphans
	docker volume prune -f
	docker volume prune -af

re: fclean up

.PHONY: all up down clean fclean re