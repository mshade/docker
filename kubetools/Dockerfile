FROM alpine as pkgs
ARG PKGS="curl"

ARG KUBECTL_VER="v1.22.4"
ARG KUBEVAL_VER="v0.16.1"
ARG KREW_VER="v0.4.2"
ARG HELM2_VER="v2.17.0"
ARG HELM3_VER="v3.7.1"
ARG HELMFILE_VER="v0.142.0"

WORKDIR /pkgs

RUN apk add --no-cache $PKGS && \
  curl -LOs https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VER}/bin/linux/amd64/kubectl && \
  curl -Ls https://get.helm.sh/helm-${HELM2_VER}-linux-amd64.tar.gz | tar -xvz linux-amd64/helm && \
  mv -v linux-amd64/helm helm2 && \
  curl -Ls https://get.helm.sh/helm-${HELM3_VER}-linux-amd64.tar.gz | tar -xvz linux-amd64/helm && \
  mv -v linux-amd64/helm helm3 && \
  curl -Ls https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VER}/kubeval-linux-amd64.tar.gz | tar -xvz kubeval && \
  curl -Ls https://github.com/roboll/helmfile/releases/download/${HELMFILE_VER}/helmfile_linux_amd64 > helmfile && \
  curl -Ls https://github.com/kubernetes-sigs/krew/releases/download/${KREW_VER}/krew-linux_amd64.tar.gz | tar -xvz ./krew-linux_amd64 && \
  mv krew-linux_amd64 krew && \
  # Clean up and set executable
  rm -rf linux-amd64 && chmod +x *
  

FROM alpine:edge
LABEL maintainer="Mike Shade mshade@mshade.org"

RUN apk add --no-cache bash bash-completion curl git jq kubectx openssl sudo vim yq

RUN adduser -h /home -s /bin/bash -D -u 1000 -G wheel kubetools && \
  echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel


COPY --from=pkgs /pkgs/* /usr/local/bin/

RUN chmod +x /usr/local/bin/* && \
  ln -s /usr/local/bin/helm3 /usr/local/bin/helm

USER kubetools
WORKDIR /app
RUN helm3 plugin install https://github.com/databus23/helm-diff && \
  curl -s https://raw.githubusercontent.com/cykerway/complete-alias/master/complete_alias > /home/.complete_alias && \
  krew install krew && \
  export PATH=~/.krew/bin:$PATH && \
  kubectl krew index add kvaps https://github.com/kvaps/krew-index && \
  kubectl krew install kvaps/node-shell

COPY .bashrc .vimrc /home/
CMD /bin/bash
