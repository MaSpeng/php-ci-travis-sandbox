-include .env
export

.PHONY: install
install:
	@echo "Installing dependencies and development tools"
	@docker-compose run --entrypoint /bin/sh --rm composer -c " \
		composer install && \
		composer bin phpunit install && \
		composer bin phpstan install && \
		composer bin squizlabs install \
	"

.PHONY: analysis
analysis:
	@echo "Analyse code"
	@docker-compose run --no-deps --rm php php vendor/bin/phpstan --version
	@docker-compose run --no-deps --rm php php vendor/bin/phpstan analyze --autoload-file=/var/www/app/vendor/autoload.php src tests

.PHONY: style-check
check-style:
	@echo "Checking code style"
	@docker-compose run --no-deps --rm php php vendor/bin/phpcs --version
	@docker-compose run --no-deps --rm php php vendor/bin/phpcs -p

.PHONY: style-fix
fix-style:
	@echo "Fixing code style"
	@docker-compose run --no-deps --rm php php vendor/bin/phpcbf --version
	@docker-compose run --no-deps --rm php php vendor/bin/phpcbf -p

.PHONY: test
test:
	@echo "Running tests"
	@docker-compose run --no-deps --rm php php vendor/bin/simple-phpunit --version
	@docker-compose run --no-deps --rm php php vendor/bin/simple-phpunit

.PHONY: test-with-coverage
test-with-coverage:
	@echo "Running tests with code coverage"
	@docker-compose run --no-deps --rm php php vendor/bin/simple-phpunit --version
	@docker-compose run --no-deps --rm php \
		php -dzend_extension=xdebug.so vendor/bin/simple-phpunit

.PHONY: start
start:
	@docker-compose run --rm --detach --name ${COMPOSE_PROJECT_NAME}_nginx --service-ports nginx

.PHONY: stop
stop:
	@docker-compose down

.PHONY: restart
restart: stop start
