all: build push
test: build pushtest

build:
	docker build -t jcderr/concourse-kubernetes-resource:local .

push:
	docker tag jcderr/concourse-kubernetes-resource:local jcderr/concourse-kubernetes-resource:latest
	docker push jcderr/concourse-kubernetes-resource:latest

pushtest:
	docker tag jcderr/concourse-kubernetes-resource:local jcderr/concourse-kubernetes-resource:test
	docker push jcderr/concourse-kubernetes-resource:test
