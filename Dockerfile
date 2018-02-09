FROM alpine:latest

WORKDIR /tmp/build

ENV runDependencies curl jq bash
ENV kubectlURL https://storage.googleapis.com/kubernetes-release/release/v1.9.2/bin/linux/amd64/kubectl

RUN apk --no-cache add ${runDependencies}; \
    curl -L -o /usr/local/bin/kubectl \
        ${kubectlURL}; \
    chmod +x /usr/local/bin/kubectl

ADD bin/check /opt/resource/check
ADD bin/in /opt/resource/in
ADD bin/out /opt/resource/out

CMD /usr/local/bin/kubectl
