FROM garethr/kubeval:0.15.0 as kubeval

FROM alpine as pkgs
ARG PKGS="curl"

ARG KUBECTL_VER="v1.18.2"
ARG HELM2_VER="v2.16.7"
ARG HELM3_VER="v3.2.1"

WORKDIR /pkgs

RUN apk add --no-cache $PKGS && \
  curl -LOs https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VER/bin/linux/amd64/kubectl && \
  curl -L -s https://get.helm.sh/helm-$HELM2_VER-linux-amd64.tar.gz | tar -xvz linux-amd64/helm && \
  mv -v linux-amd64/helm helm2 && \
  curl -L -s https://get.helm.sh/helm-$HELM3_VER-linux-amd64.tar.gz | tar -xvz linux-amd64/helm && \
  mv -v linux-amd64/helm helm3 && \
  rm -rf linux-amd64 && chmod +x *


FROM alpine

RUN apk add --no-cache bash

WORKDIR /app

COPY --from=kubeval /kubeval /usr/local/bin/
COPY --from=pkgs /pkgs/* /usr/local/bin/

RUN chmod +x /usr/local/bin/*

ENTRYPOINT /bin/bash

