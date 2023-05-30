DOCKER_COMPOSE_PATH="./docker/docker-compose.yml"
DOCKER_FILE_PATH="./docker/Dockerfile"
IMAGE="sqlserver-geracao-ecf"
IMAGE_VERSION="default"

build:
	docker build -f $(DOCKER_FILE_PATH) -t $(IMAGE):$(IMAGE_VERSION) --progress=plain .

up:
	docker compose -f $(DOCKER_COMPOSE_PATH) up -d --build
	docker compose -f $(DOCKER_COMPOSE_PATH) logs -f

down:
	docker compose -f $(DOCKER_COMPOSE_PATH) down --volumes --timeout 0
