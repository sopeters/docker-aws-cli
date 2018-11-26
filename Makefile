AWS_CLI_VERSION = 1.16.55
JP_VERSION=0.1.3

IMAGE_NAME ?= xmission/aws-cli:$(AWS_CLI_VERSION)
TAG = $(AWS_CLI_VERSION)

build:
	docker build --build-arg AWS_CLI_VERSION=$(AWS_CLI_VERSION) --build-arg JP_VERSION=$(JP_VERSION)  -t $(IMAGE_NAME) .

test:
	docker run --rm -it $(IMAGE_NAME) aws --version
	docker run --rm -it $(IMAGE_NAME) jp --version

shell:
	docker run --rm -it -v ~/.aws:/root/.aws -v $(shell pwd):/opt/app $(IMAGE_NAME) bash

dockerPush:
        docker push $(IMAGE_NAME)

gitTag:
	-git tag -d $(TAG)
	-git push origin :refs/tags/$(TAG)
	git tag $(TAG)
	git push origin $(TAG)
