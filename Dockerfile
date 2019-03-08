FROM alpine:edge

ARG KUSTOMIZE_URL="https://github.com/kubernetes-sigs/kustomize/releases/download/v2.0.3/kustomize_2.0.3_linux_amd64"
ARG K9S_URL="https://github.com/derailed/k9s/releases/download/0.2.1/k9s_0.2.1_Linux_x86_64.tar.gz"
ARG KUBECTL_URL="https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kubectl"

ENV LANG="en_US.UTF-8"      \
    LC_ALL="en_US.UTF-8"    \
    LANGUAGE="en_US.UTF-8"  \
    EDITOR="vim"            \
    TERM="xterm"

RUN apk --update add zsh tmux               \
      curl fping wget bind-tools            \
      htop man tar tree                     \
    && rm -rf /var/cache/apk/* /tmp/src

RUN apk --update add git docker vim   \
    && rm -rf /var/cache/apk/* /tmp/src

COPY --from=wagoodman/dive:latest /dive /bin/dives

WORKDIR /tmp
RUN curl -ksLo kustomize $KUSTOMIZE_URL \
  && chmod +x kustomize                 \
  && mv kustomize /bin                  \
  && rm -rf *

RUN curl -ksLo k9s.tar.gz $K9S_URL  \
  && tar -xzvf k9s.tar.gz           \
  && chmod +x k9s                   \
  && mv k9s /bin                    \
  && rm -rf *

RUN curl -ksLo kubectl $KUBECTL_URL \
  && chmod +x kubectl       \
  && mv kubectl /bin        \
  && rm -rf *

COPY files/.vimrc ~/.vimrc

WORKDIR /
CMD ["/bin/zsh"]

docker run -it --pid=container:caddy \
  --net=container:caddy \
  --cap-add sys_admin \
  ahstn/debug zsh
