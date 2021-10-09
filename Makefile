## Name of the images
DOCKER_BASE=dsuite/alpine-base:test
DOCKER_RUNIT=dsuite/alpine-runit:test

## Current directory
DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

## Config
.DEFAULT_GOAL := help
.PHONY: *

help: ## This help !
	@printf "\033[33mUsage:\033[0m\n  make [target]\n\n\033[33mTargets:\033[0m\n"
	@grep -E '^[-a-zA-Z0-9_\.\/]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Build base and runit image
	@$(MAKE) build-base
	@$(MAKE) build-runit

test: ## Test base and runit image
	@$(MAKE) test-base
	@$(MAKE) test-runit

shell: ## Run shell ( usage : make shell v="base" Or make shell v="runit")
	$(eval version := $(or $(v), base))
	@if [ "$(version)" = "base" ]; then $(MAKE) shell-base; fi
	@if [ "$(version)" = "runit" ]; then $(MAKE) shell-runit; fi

remove:  ## Remove images
	@$(MAKE) remove-base
	@$(MAKE) remove-runit

build-base:
	@docker build \
		--file test/Dockerfile-base.test \
		--tag $(DOCKER_BASE) \
		$(DIR)

build-runit:
	@docker build \
		--file test/Dockerfile-runit.test \
		--tag $(DOCKER_RUNIT) \
		$(DIR)

test-base:
	@GOSS_FILES_PATH=$(DIR)/test/alpine-base \
	 	dgoss run $(DOCKER_BASE) bash -c "sleep 60"
	@GOSS_FILES_PATH=$(DIR)/test/alpine-base \
	 	dgoss run -e DEBUG_LEVEL=DEBUG -e USER=test $(DOCKER_BASE) bash -c "sleep 60"
	@GOSS_FILES_PATH=$(DIR)/test/alpine-base \
	 	dgoss run -e DEBUG_LEVEL=DEBUG -e BOOT_DELAY=1 $(DOCKER_BASE) bash -c "sleep 60"

test-runit:
	@GOSS_FILES_PATH=$(DIR)/test/alpine-base \
	 	dgoss run $(DOCKER_RUNIT)
	@GOSS_FILES_PATH=$(DIR)/test/alpine-runit \
	 	dgoss run $(DOCKER_RUNIT)

shell-base:
	@docker run -it --rm \
		-e DEBUG_LEVEL=DEBUG \
		-u 1000 \
		--name base-test \
		$(DOCKER_BASE) \
		bash

shell-runit:
	@docker run -it --rm \
		-e DEBUG_LEVEL=DEBUG \
		-e MAIN_RESTART=1 \
		-e USER=test \
		--name runit-test \
		$(DOCKER_RUNIT) \
		bash

remove-base:
	@if [ $$(docker images -q $(DOCKER_BASE) | wc -l) -eq 1 ] ; then \
		docker rmi $(DOCKER_BASE) -f; \
	fi

remove-runit:
	@if [ $$(docker images -q $(DOCKER_RUNIT) | wc -l) -eq 1 ] ; then \
		docker rmi $(DOCKER_RUNIT) -f; \
	fi
