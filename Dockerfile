FROM alpine:3.4

ENV OH_MY_ZSH=/root/.oh-my-zsh LC_ALL=en_GB.UTF-8 SHELL=zsh ZSHRC=/root/.zshrc POWERLINE=/root/.powerline POWERLINE_CONF_DIR=/root/.config/powerline TMUX_CONF=/root/.tmux.conf TERM=screen-256color

WORKDIR /root

RUN apk --update --upgrade --no-cache add zsh git vim tmux ca-certificates openssl

RUN git clone https://github.com/robbyrussell/oh-my-zsh $OH_MY_ZSH && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $OH_MY_ZSH/custom/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

RUN cp $OH_MY_ZSH/templates/zshrc.zsh-template $ZSHRC
RUN sed -i -e 's/^plugins=.*/plugins=(docker git screen history-substring-search zsh-syntax-highlighting)/' $ZSHRC
RUN sed -i -e 's/^ZSH_THEME=.*/ZSH_THEME=darkblood/' $ZSHRC
RUN git config --global core.editor "vim" && \
    git config --global user.name "Tom Cammann" && \
    git config --global user.email "tom.cammann@hpe.com" && \
    git config --global color.ui true
COPY tmux.conf $TMUX_CONF
COPY extras.zsh extras.zsh
RUN cat >> $ZSHRC < extras.zsh
RUN rm extras.zsh
COPY vimrc /root/.vimrc
RUN mkdir -p ~/.vim/backup && mkdir -p ~/.vim/undo && mkdir -p ~/.vim/tmp
RUN vim "+silent NeoBundleInstall" +qa

ENTRYPOINT ["tmux"]
