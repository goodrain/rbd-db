SHELL := /bin/bash

default: help
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: build
build:	## build rbd-db image
	docker build -t rainbond/rbd-db .
.PHONY: push
push:	## push image 
	docker push rainbond/rbd-db
.PHONY: all
all:	build push ## build && push
.PHONY: clean 
clean: ## clean built image
	docker rmi -f rainbond/rbd-db
