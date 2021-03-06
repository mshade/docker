FROM alpine as pkgs
ARG PKGS="curl"

ARG KUBECTL_VER="v1.21.1"
ARG KUBEVAL_VER="v0.16.1"
ARG HELM2_VER="v2.17.0"
ARG HELM3_VER="v3.5.4"

WORKDIR /pkgs

RUN apk add --no-cache $PKGS && \
  curl -LOs https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VER/bin/linux/amd64/kubectl && \
  curl -L -s https://get.helm.sh/helm-$HELM2_VER-linux-amd64.tar.gz | tar -xvz linux-amd64/helm && \
  mv -v linux-amd64/helm helm2 && \
  curl -L -s https://get.helm.sh/helm-$HELM3_VER-linux-amd64.tar.gz | tar -xvz linux-amd64/helm && \
  mv -v linux-amd64/helm helm3 && \
  curl -L https://github.com/instrumenta/kubeval/releases/download/$KUBEVAL_VER/kubeval-linux-amd64.tar.gz | tar -xvz kubeval && \
  rm -rf linux-amd64 && chmod +x *


FROM alpine
LABEL maintainer="Mike Shade mshade@mshade.org"

RUN apk add --no-cache bash curl

WORKDIR /app

COPY --from=pkgs /pkgs/* /usr/local/bin/

RUN chmod +x /usr/local/bin/*

CMD /bin/bash

