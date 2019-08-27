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
REGISTRY ?= "docker.io/7val"

## Constant
IMAGE_NAME="$(REGISTRY)/$(SERVICE)"

## Targets

help:
	@if tty -s ; then \
		grep -E '^[a-zA-Z_-]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'; \
	else \
		grep -E '^[a-zA-Z_-]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'; \
	fi

version: ## Print current version
	@echo $(VERSION)

build: ## Build image
	@docker build \
		-t $(IMAGE_NAME):$(VERSION) \
		-f services/$(SERVICE)/Dockerfile \
		--target release \
		services/$(SERVICE)

push: ## Push image
	@docker push $(IMAGE_NAME):$(VERSION)

deploy: ## Deploy application
	# Build deploy
# HINT!!! Only necessary when your Gitlab Runner is a Docker container.
	@GITLAB_RUNNER_ID="$(shell docker ps -q -f "label=com.gitlab.gitlab-runner.job.id=$(CI_JOB_ID)" --format '{{.Names}}' )" \
		docker-compose \
		-p {{ PROJECT_NAME }}-deploy-$(VERSION)_$(CI_JOB_ID) \
		-f ops/docker-compose.ops.yml \
		build \
		--force-rm \
		--no-cache \
		--pull \
		deploy-$(ENVIRONMENT)
	# Run deploy
# HINT!!! Only necessary when your Gitlab Runner is a Docker container.
	@GITLAB_RUNNER_ID="$(shell docker ps -q -f "label=com.gitlab.gitlab-runner.job.id=$(CI_JOB_ID)" --format '{{.Names}}' )" \
		ops/trap_command.sh \
		"docker-compose -p {{ PROJECT_NAME }}-deploy-$(VERSION)_$(CI_JOB_ID) -f ops/docker-compose.ops.yml run -T --rm -e VERSION=$(VERSION) deploy-$(ENVIRONMENT)" \
		"docker-compose -p {{ PROJECT_NAME }}-deploy-$(VERSION)_$(CI_JOB_ID) -f ops/docker-compose.ops.yml down -v --remophe-orphans"
