FROM alpine as pkgs
ARG PKGS="curl"

<<<<<<< HEAD
ARG KUBECTL_VER="v1.22.4"
ARG KUBEVAL_VER="v0.16.1"
ARG KREW_VER="v0.4.2"
ARG HELM2_VER="v2.17.0"
ARG HELM3_VER="v3.9.0"
ARG HELMFILE_VER="v0.142.0"
ARG VELERO_VERSION="v1.8.1"

WORKDIR /pkgs

RUN set -e && \
  apk add --no-cache $PKGS && \
  curl -LOs https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VER}/bin/linux/amd64/kubectl && \
  curl -Ls https://get.helm.sh/helm-${HELM2_VER}-linux-amd64.tar.gz | tar -xvz linux-amd64/helm && \
  mv -v linux-amd64/helm helm2 && \
  curl -Ls https://get.helm.sh/helm-${HELM3_VER}-linux-amd64.tar.gz | tar -xvz linux-amd64/helm && \
  mv -v linux-amd64/helm helm3 && \
  curl -Ls https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VER}/kubeval-linux-amd64.tar.gz | tar -xvz kubeval && \
  curl -Ls https://github.com/roboll/helmfile/releases/download/${HELMFILE_VER}/helmfile_linux_amd64 > helmfile && \
  curl -Ls https://github.com/kubernetes-sigs/krew/releases/download/${KREW_VER}/krew-linux_amd64.tar.gz | tar -xvz ./krew-linux_amd64 && \
  mv krew-linux_amd64 krew && \
  curl -Ls https://github.com/vmware-tanzu/velero/releases/download/${VELERO_VERSION}/velero-${VELERO_VERSION}-linux-amd64.tar.gz \
  | tar -xvz velero-${VELERO_VERSION}-linux-amd64/velero && mv -v velero*/velero velero && \
  # Clean up and set executable
  rm -rf linux-amd64 velero-${VELERO_VERSION}* && chmod +x *
=======
ARG K9S_VER="v0.26.0"
ARG KUBECTL_VER="v1.24.2"
ARG KUBECONFORM_VER="v0.4.13"
ARG KREW_VER="v0.4.3"
ARG HELM2_VER="v2.17.0"
ARG HELM3_VER="v3.9.0"
ARG HELMFILE_VER="v0.144.0"
ARG VELERO_VERSION="v1.9.0"
ARG ARCH="amd64"
ARG K9S_ARCH="x86_64"

WORKDIR /pkgs

RUN set -e &&  \
  apk add --no-cache $PKGS &&  \
  curl -Ls https://github.com/derailed/k9s/releases/download/${K9S_VER}/k9s_Linux_${K9S_ARCH}.tar.gz | tar -xvz k9s && \
  curl -LOs https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VER}/bin/linux/${ARCH}/kubectl && \
  curl -Ls https://get.helm.sh/helm-${HELM2_VER}-linux-${ARCH}.tar.gz | tar -xvz linux-${ARCH}/helm && \
  mv -v linux-${ARCH}/helm helm2 && \
  curl -Ls https://get.helm.sh/helm-${HELM3_VER}-linux-${ARCH}.tar.gz | tar -xvz linux-${ARCH}/helm && \
  mv -v linux-${ARCH}/helm helm3 && \
  curl -Ls https://github.com/yannh/kubeconform/releases/download/${KUBECONFORM_VER}/kubeconform-linux-${ARCH}.tar.gz | tar -xvz kubeconform && \
  curl -Ls https://github.com/roboll/helmfile/releases/download/${HELMFILE_VER}/helmfile_linux_${ARCH} > helmfile && \
  curl -Ls https://github.com/kubernetes-sigs/krew/releases/download/${KREW_VER}/krew-linux_${ARCH}.tar.gz | tar -xvz ./krew-linux_${ARCH} && \
  mv krew-linux_${ARCH} krew && \
  curl -Ls https://github.com/vmware-tanzu/velero/releases/download/${VELERO_VERSION}/velero-${VELERO_VERSION}-linux-${ARCH}.tar.gz \
  | tar -xvz velero-${VELERO_VERSION}-linux-${ARCH}/velero && mv -v velero*/velero velero && \
  # Clean up and set executable
  rm -rf linux-${ARCH} velero-${VELERO_VERSION}* && chmod +x *
>>>>>>> 2beb3a40dad1a106d331cfc64da713176a70d196
  

FROM alpine:edge
LABEL maintainer="Mike Shade mshade@mshade.org"

RUN set -e && \
  apk add --no-cache bash bash-completion bind-tools curl \
  docker-cli docker-cli-compose docker-cli-buildx docker-compose  docker-compose-bash-completion \
  gcompat gettext git groff jq kubectx openssl sudo vim yq

RUN adduser -h /home -s /bin/bash -D -u 1000 -G wheel kubetools && \
  echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel


COPY --from=pkgs /pkgs/* /usr/local/bin/

RUN chmod +x /usr/local/bin/* && \
  ln -s /usr/local/bin/helm3 /usr/local/bin/helm

USER kubetools
WORKDIR /app
RUN set -e && \
  helm3 plugin install https://github.com/databus23/helm-diff && \
  curl -s https://raw.githubusercontent.com/cykerway/complete-alias/master/complete_alias > /home/.complete_alias && \
  krew install krew && \
  export PATH=~/.krew/bin:$PATH && \
  kubectl krew index add kvaps https://github.com/kvaps/krew-index && \
  kubectl krew install kvaps/node-shell && \
  kubectl krew update && kubectl krew install pv-migrate

COPY .bashrc .vimrc /home/
CMD /bin/bash
