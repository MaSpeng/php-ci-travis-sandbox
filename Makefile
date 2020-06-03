-include .env
export

.PHONY: default
default: lint start

.PHONY: analysis
analysis:
	@echo "Analyse code"
	@docker-compose run --no-deps --rm php composer run-script --timeout=0 --no-interaction -- analyze-code

.PHONY: install
install:
	@echo "Installing dependencies and development tools"
	@COMPOSE_DOCKER_BUILDKIT=1 docker-compose build php
	@docker-compose run --rm php composer install
	@docker-compose run --rm php composer run-script --timeout=0 --no-interaction -- install-tools

.PHONY: lint
lint:
	@echo "Checking code style"
	@docker-compose run --no-deps --rm php composer run-script --timeout=0 --no-interaction -- lint
	@echo "Checking configuration"
	@docker-compose run --no-deps --rm php composer run-script --timeout=0 --no-interaction -- lint-config
	@echo "Checking container"
	@docker-compose run --no-deps --rm php composer run-script --timeout=0 --no-interaction -- lint-container

.PHONY: style-fix
fix-style:
	@echo "Fixing code style"
	@docker-compose run --no-deps --rm php composer run-script --timeout=0 --no-interaction -- fix-style

.PHONY: test
test:
	@echo "Running tests"
	@docker-compose run --no-deps --rm php composer run-script --timeout=0 --no-interaction -- test

.PHONY: test-with-coverage
test-with-coverage:
	@echo "Running tests with code coverage"
	@docker-compose run --no-deps --rm -e PCOV_ENABLE=On php composer run-script --timeout=0 --no-interaction -- test-with-coverage

.PHONY: restart
restart: stop start

.PHONY: start
start:
	@echo "Starting backend server"
	@docker-compose up --detach nginx

.PHONY: status
status:
	@docker-compose ps
	@echo
	@docker-compose logs

.PHONY: stop
stop:
	@echo "Stopping all services"
	@docker-compose down

.PHONY: uninstall
uninstall:
	@echo "Stopping servers and removing containers, images, volumes and orphans"
	@docker-compose down --rmi local --volumes --remove-orphans

.PHONY: update-images
update-images:
	@echo "Updating images"
	@COMPOSE_DOCKER_BUILDKIT=1 docker-compose build
