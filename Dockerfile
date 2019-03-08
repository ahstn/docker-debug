FROM alpine:edge

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    TERM="xterm"

RUN apk -U upgrade                          \
    && apk --update add bash zsh tmux       \
      curl fping wget bind-tools            \
      htop man mc mtr musl-dev tar tree xz  \
      git docker vim                        \
    && rm -rf /tmp/gotty /var/cache/apk/* /tmp/src

COPY files/.vimrc ~/.vimrc

CMD ["/bin/zsh"] 
