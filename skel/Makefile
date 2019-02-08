.PHONY: version build push deploy

# Builds, pushes and deploys the project. If needed all management operations
# can be added here too.
#
# Arguments:
#    SERVICE must be set
#    VERSION, ENVIRONMENT and REGISTRY can be set

## Variables which can be overiden on the command line.

# Format: 2019-01-29-c515510
VERSION ?= "$(shell git show --quiet --format="%cd-%h" --date=short)"
ENVIRONMENT ?= "development"
REGISTRY ?= "my.registry.io"

## Constant
IMAGE_NAME="$(REGISTRY)/$(SERVICE)"

## Targets

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
