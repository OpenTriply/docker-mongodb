VERSION=`cat VERSION`
IMAGE := "triply/mongodb"

.PHONY: all build release up bash sudo restart stop logs
all: build

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build        - build the image"
	@echo "   2. make release      - release the image"
	@echo "   2. make up				   - start container"
	@echo "   3. make stop         - stop container"
	@echo "   4. make logs         - view logs"


build: stop
	@docker build --tag=${IMAGE}:latest .
	@docker tag -f  ${IMAGE}:latest ${IMAGE}:${VERSION}

release:
	@docker tag -f  ${IMAGE}:latest ${IMAGE}:${VERSION}

up:
	@echo "Starting starting container"
	@docker-compose up -d
	@echo "Started as daemon. Run 'make logs' to show the container output"

bash:
	@docker exec -it -u mongodb `docker ps -q --filter "name=${IMAGE}*"" |  xargs --no-run-if-empty docker inspect --format '{{ .Name }}' | tail -c +2` bash || docker-compose run mongodb su - mongodb

sudo:
	@docker exec -it `docker ps -q --filter "name=${IMAGE}*"" |  xargs --no-run-if-empty docker inspect --format '{{ .Name }}' | tail -c +2` bash || docker-compose run mongodb /bin/bash

restart: stop up

stop:
	@echo "Stopping container..."
	@docker-compose stop

logs:
	@docker-compose logs
