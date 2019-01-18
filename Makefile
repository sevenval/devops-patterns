.PHONY: version build push deploy

VERSION ?= "$(shell git show --quiet --format="%cd-%h" --date=short)"
ENVIRONMENT ?= "development"

version:
	@echo $(VERSION)

build:

push:

deploy:
