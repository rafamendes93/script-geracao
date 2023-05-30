DOCKER_COMPOSE_PATH="./docker/docker-compose.yml"

up:
	docker compose -f $(DOCKER_COMPOSE_PATH) up -d --build
	docker compose -f $(DOCKER_COMPOSE_PATH) logs -f

down:
	docker compose -f $(DOCKER_COMPOSE_PATH) down
