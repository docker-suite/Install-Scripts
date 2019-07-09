DOCKER_BASE=dsuite/alpine-base:test
DOCKER_RUNIT=dsuite/alpine-runit:test

DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

build: build-base build-runit

build-base:
	docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file tests/dockerfiles/Dockerfile-base.test \
		--tag $(DOCKER_BASE) \
		.

build-runit:
	docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file tests/dockerfiles/Dockerfile-runit.test \
		--tag $(DOCKER_RUNIT) \
		.


test: test-base test-runit

test-base: build-base
	docker run --rm -it \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests/alpine-base:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e NEW_UID=1005 -e http_proxy=${http_proxy} -e https_proxy=${https_proxy} --entrypoint=/goss/entrypoint.sh $(DOCKER_BASE)
	docker run --rm -it \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e GOSS_SLEEP=2 \
		-v $(DIR)/tests/alpine-base:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e BOOT_DELAY=0 -e NEW_GID=1005 -e http_proxy=${http_proxy} -e https_proxy=${https_proxy} --entrypoint=/goss/entrypoint.sh $(DOCKER_BASE)

test-runit: test-base build-runit
	docker run --rm -it \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests/alpine-runit:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e http_proxy=${http_proxy} -e https_proxy=${https_proxy} --entrypoint=/goss/entrypoint.sh $(DOCKER_RUNIT)


shell-base: build-base
	docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		$(DOCKER_BASE) \
		bash

shell-runit: build-runit
	docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		$(DOCKER_RUNIT) \
		bash


remove: remove-base remove-runit

remove-base:
	@if [ $$(docker images -q $(DOCKER_BASE) | wc -l) -eq 1 ] ; then \
		docker rmi $(DOCKER_BASE) -f; \
	fi

remove-runit:
	@if [ $$(docker images -q $(DOCKER_RUNIT) | wc -l) -eq 1 ] ; then \
		docker rmi $(DOCKER_RUNIT) -f; \
	fi
