FROM golang:1.7-alpine

ENV OH_MY_ZSH=/root/.oh-my-zsh LC_ALL=en_GB.UTF-8 ZSHRC=/root/.zshrc TERM=screen-256color

WORKDIR /root

RUN apk --update --upgrade --no-cache add zsh git vim tmux ca-certificates openssl docker less

RUN git clone https://github.com/robbyrussell/oh-my-zsh $OH_MY_ZSH && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $OH_MY_ZSH/custom/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

COPY tmux.conf /root/.tmux.conf
COPY extras.zsh extras.zsh
COPY vimrc /root/.vimrc

# INFO: Blank screen while downloading
RUN vim "+silent NeoBundleInstall" +qa && \
    vim "+silent GoInstallBinaries" +qa

RUN cp $OH_MY_ZSH/templates/zshrc.zsh-template $ZSHRC && \
    cat >> $ZSHRC < extras.zsh && \
    rm extras.zsh && \
    sed -i -e 's/^plugins=.*/plugins=(zsh-syntax-highlighting docker git screen history-substring-search)/' $ZSHRC && \
    sed -i -e 's/^ZSH_THEME=.*/ZSH_THEME=darkblood/' $ZSHRC && \
    git config --global core.editor "vim" && \
    git config --global user.name "Tom Cammann" && \
    git config --global user.email "tom.cammann@hpe.com" && \
    git config --global color.ui true && \
    mkdir -p ~/.vim/backup && mkdir -p ~/.vim/undo && mkdir -p ~/.vim/tmp

ENTRYPOINT ["tmux"]
