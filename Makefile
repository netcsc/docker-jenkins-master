.PHONY: build push

all: build push

build:
	docker build -t <repo>/jenkins:lts  --build-arg http_proxy=<http_proxy> --build-arg https_proxy=<https_proxy>  ./

push:
	docker push <repo>/jenkins:lts