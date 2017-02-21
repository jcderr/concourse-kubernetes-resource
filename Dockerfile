FROM alpine:latest

WORKDIR /tmp/build

ENV runDependencies curl jq bash
ENV kubectlURL https://storage.googleapis.com/kubernetes-release/release/v1.5.3/bin/linux/amd64/kubectl

RUN apk --no-cache add ${runDependencies}; \
    curl -L -o /usr/local/bin/kubectl \
        ${kubectlURL}; \
    chmod +x /usr/local/bin/kubectl

ADD bin/* /opt/resource/

CMD /usr/local/bin/kubectl
