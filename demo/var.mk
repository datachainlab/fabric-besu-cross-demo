DOCKER         ?= docker
DOCKER_BUILD   ?= $(DOCKER) build --rm --no-cache --pull
DOCKER_COMPOSE ?= docker-compose

FABRIC_VERSION    ?=2.2.0
FABRIC_CA_VERSION ?=1.4.7
FABRIC_PLATFORM   ?=linux/amd64
