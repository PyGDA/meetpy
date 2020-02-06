.PHONY: docker-build \
	docker-login \
	docker-push

TAG = latest

docker-build:
	@docker build . -t pykonik/meetpy:$(TAG)

docker-login:
	@echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USER --password-stdin

docker-push: docker-login
	@docker push pykonik/meetpy:$(TAG)

piptools:
	pip install pip --upgrade
	pip install pip-tools

deps: piptools
	pip-compile requirements.in -o requirements.txt --upgrade
	pip-compile requirements-pg.in -o requirements-pg.txt --upgrade

install: piptools
	pip-sync requirements.txt
