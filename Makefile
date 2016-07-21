all: build push

build:
	docker build -t jcderr/concourse-kubernetes-resource:latest .

push:
	docker push jcderr/concourse-kubernetes-resource:latest
