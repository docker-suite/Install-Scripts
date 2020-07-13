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
	@docker build --force-rm \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--build-arg no_proxy=${no_proxy} \
		--file test/Dockerfile-base.test \
		--tag $(DOCKER_BASE) \
		$(DIR)

build-runit:
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--build-arg no_proxy=${no_proxy} \
		--file test/Dockerfile-runit.test \
		--tag $(DOCKER_RUNIT) \
		$(DIR)

test-base:
	@$(MAKE) build-base
	@docker run -t --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e no_proxy=${no_proxy} \
		-v $(DIR)/test/alpine-base:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e http_proxy=${http_proxy} -e https_proxy=${https_proxy} -e no_proxy=${no_proxy} --entrypoint=/goss/entrypoint.sh $(DOCKER_BASE)
	@docker run -t --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e no_proxy=${no_proxy} \
		-v $(DIR)/test/alpine-base:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e NEW_UID=1005 -e http_proxy=${http_proxy} -e https_proxy=${https_proxy} -e no_proxy=${no_proxy} --entrypoint=/goss/entrypoint.sh $(DOCKER_BASE)
	@docker run -t --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e no_proxy=${no_proxy} \
		-e GOSS_SLEEP=2 \
		-v $(DIR)/test/alpine-base:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e BOOT_DELAY=0 -e NEW_GID=1005 -e http_proxy=${http_proxy} -e https_proxy=${https_proxy} -e no_proxy=${no_proxy} --entrypoint=/goss/entrypoint.sh $(DOCKER_BASE)

test-runit:
	@$(MAKE) build-runit
	docker run -t --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e no_proxy=${no_proxy} \
		-v $(DIR)/test/alpine-runit:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e http_proxy=${http_proxy} -e https_proxy=${https_proxy} -e no_proxy=${no_proxy} --entrypoint=/goss/entrypoint.sh $(DOCKER_RUNIT)


shell-base:
	@$(MAKE) build-base
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e no_proxy=${no_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		--name base-test \
		$(DOCKER_BASE) \
		bash

shell-runit:
	@$(MAKE) build-runit
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e no_proxy=${no_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		-e MAIN_RESTART=1 \
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
