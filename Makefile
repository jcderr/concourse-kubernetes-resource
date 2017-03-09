all: build push
test: build pushtest

build:
	docker build -t vise890/concourse-kubernetes-resource:local .

push:
	docker tag vise890/concourse-kubernetes-resource:local vise890/concourse-kubernetes-resource:latest
	docker push vise890/concourse-kubernetes-resource:latest

pushtest:
	docker tag vise890/concourse-kubernetes-resource:local vise890/concourse-kubernetes-resource:test
	docker push vise890/concourse-kubernetes-resource:test
