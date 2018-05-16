FROM alpine

MAINTAINER Egor Zyuskin <ezyuskin@codenetix.com>

ENV RANCHERCLI_VERSION="v2.0.0"
ENV KUBECTL_VERSION="v1.10.2"

WORKDIR /root 

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl tar \
 && curl -L https://releases.rancher.com/cli/${RANCHERCLI_VERSION}/rancher-linux-amd64-${RANCHERCLI_VERSION}.tar.gz | zcat - | tar xvf - \
 && mv ./rancher-${RANCHERCLI_VERSION}/rancher /usr/local/bin/ \
 && rm -fr ./rancher-${RANCHERCLI_VERSION}/ \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rancher -v \
 && rm /var/cache/apk/*
