.PHONY: version build push deploy

# Builds, pushes and deploys the project.
# Arguments:
#    SERVICE must be set
#    VERSION, ENVIRONMENT and REGISTRY can be set

VERSION ?= "$(shell git show --quiet --format="%cd-%h" --date=short)"
ENVIRONMENT ?= "development"
REGISTRY ?= "my.registry.io"

IMAGE_NAME="$(REGISTRY)/$(SERVICE)"

version:
	@echo $(VERSION)

build:
	@docker build \
		-t $(IMAGE_NAME):$(VERSION) \
		-f services/$(SERVICE)/Dockerfile \
		--target release \
		services/$(SERVICE)

push:
	@docker push $(IMAGE_NAME):$(VERSION)

deploy:
	# Build
	@docker-compose \
		-f ops/docker-compose.ops.yaml \
		build \
		--force-rm \
		--no-cache \
		--pull \
		deploy-$(ENVIRONMENT)
	# Run
	@docker-compose \
		-f ops/docker-compose.ops.yaml \
		run \
		--rm \
		-e VERSION=$(VERSION) \
		deploy-$(ENVIRONMENT)
