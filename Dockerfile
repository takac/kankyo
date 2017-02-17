FROM alpine:3.4

ENV OH_MY_ZSH /root/.oh-my-zsh
ENV LC_ALL en_GB.UTF-8
ENV SHELL zsh
ENV ZSHRC /root/.zshrc
ENV POWERLINE /root/.powerline
ENV POWERLINE_CONF_DIR /root/.config/powerline
ENV TMUX_CONF /root/.tmux.conf
WORKDIR /root

RUN apk --update --upgrade add zsh git vim tmux ncurses python ca-certificates
# rm -rf /var/cache/apk/* \
# && find / -type f -iname \*.apk-new -delete \
# && rm -rf /var/cache/apk/*

RUN git clone https://github.com/robbyrussell/oh-my-zsh $OH_MY_ZSH
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $OH_MY_ZSH/custom/plugins/zsh-syntax-highlighting
RUN cp $OH_MY_ZSH/templates/zshrc.zsh-template $ZSHRC
RUN sed -i -e 's/^plugins=.*/plugins=(docker git tmux screen history-substring-search zsh-syntax-highlighting)/' $ZSHRC
RUN sed -i -e 's/^ZSH_THEME=.*/ZSH_THEME=darkblood/' $ZSHRC
RUN git config --global core.editor "vim" && \
    git config --global user.name "Tom Cammann" && \
    git config --global user.email "tom.cammann@hpe.com" && \
    git config --global color.ui true
RUN git clone https://github.com/Lokaltog/powerline $POWERLINE
RUN mkdir -p ~/.config/powerline
RUN cp -r ~/.powerline/powerline/config_files/ /root/.config/powerline
COPY tmux.conf $TMUX_CONF
COPY extras.zsh extras.zsh
RUN cat >> $ZSHRC < extras.zsh
RUN rm extras.zsh
RUN rm /usr/bin/vi

ENTRYPOINT ["tmux"]
