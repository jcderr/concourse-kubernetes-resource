FROM alpine:latest

WORKDIR /tmp/build

ENV runDependencies curl jq bash
<<<<<<< HEAD
ENV kubectlURL https://storage.googleapis.com/kubernetes-release/release/v1.8.3/bin/linux/amd64/kubectl
=======
ENV kubectlURL https://storage.googleapis.com/kubernetes-release/release/v1.4.1/bin/linux/amd64/kubectl
>>>>>>> 7a76d5804d930ccc2cd8047880355c3d837dcc85

RUN apk --no-cache add ${runDependencies}; \
    curl -L -o /usr/local/bin/kubectl \
        ${kubectlURL}; \
    chmod +x /usr/local/bin/kubectl

ADD bin/check /opt/resource/check
ADD bin/in /opt/resource/in
ADD bin/out /opt/resource/out

CMD /usr/local/bin/kubectl
