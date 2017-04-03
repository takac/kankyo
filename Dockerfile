# TODO goto 1.8
FROM golang:1.7-alpine

ENV HOME=/home/kankyo
ENV TERM=screen-256color
ENV BUILD_TOOLS="automake autoconf make g++"
ENV OH_MY_ZSH $HOME/.oh-my-zsh
ENV LC_ALL en_GB.UTF-8
ENV ZSHRC $HOME/.zshrc

# TODO Can we mount the ~/.gitconfig?
ENV GIT_NAME="Tom Cammann"
ENV GIT_EMAIL="tom.cammann@hpe.com"

WORKDIR $HOME

RUN apk --update --upgrade --no-cache add zsh git vim tmux \
    ca-certificates openssl docker less sudo
RUN git clone https://github.com/ggreer/the_silver_searcher.git
RUN apk --no-cache add ${BUILD_TOOLS} pcre-dev xz-dev && \
    cd the_silver_searcher && \
    ./build.sh && \
    mv ag /usr/local/bin && \
    cd .. && \
    rm -rf the_silver_searcher \
    apk del ${BUILD_TOOLS}

RUN git clone https://github.com/robbyrussell/oh-my-zsh $OH_MY_ZSH && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $OH_MY_ZSH/custom/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim

COPY tmux.conf $HOME/.tmux.conf
COPY extras.zsh extras.zsh
COPY vimrc $HOME/.vimrc

# INFO: Blank screen while downloading
RUN vim "+silent NeoBundleInstall" +qa && \
    vim "+silent GoInstallBinaries" +qa

RUN cp $OH_MY_ZSH/templates/zshrc.zsh-template $ZSHRC && \
    cat >> $ZSHRC < extras.zsh && \
    rm extras.zsh && \
    sed -i -e 's/^plugins=.*/plugins=(zsh-syntax-highlighting docker git tmux history-substring-search)/' $ZSHRC && \
    sed -i -e 's/^ZSH_THEME=.*/ZSH_THEME=darkblood/' $ZSHRC && \
    git config --global core.editor "vim" && \
    git config --global user.name "$GIT_NAME" && \
    git config --global user.email "$GIT_EMAIL" && \
    git config --global color.ui true && \
    mkdir -p ~/.vim/backup && mkdir -p ~/.vim/undo && mkdir -p ~/.vim/tmp

RUN chown -R 1000:1000 $HOME
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
