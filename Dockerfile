# TODO goto 1.8
FROM kalilinux/kali

ENV HOME=/home/kankyo
ENV TERM=screen-256color
ENV BUILD_TOOLS="automake autoconf make g++"
ENV OH_MY_ZSH $HOME/.oh-my-zsh
ENV LC_ALL en_GB.UTF-8
ENV ZSHRC $HOME/.zshrc

# TODO read git config from git cmd
ENV GIT_NAME="Tom Cammann"
ENV GIT_EMAIL="tom.cammann@hpe.com"

WORKDIR $HOME

RUN apt update && \
    apt install -y zsh git vim tmux \
    silversearcher-ag ca-certificates openssl docker less sudo bash \
    python3 python3-dev python3-pip gcc radare2 linux-headers-amd64 \
    make musl-dev libc-dev libffi-dev kali-tools-headless

RUN pip3 install pwntools

RUN git clone https://github.com/robbyrussell/oh-my-zsh $OH_MY_ZSH && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $OH_MY_ZSH/custom/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim && \
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

COPY vimrc $HOME/.vimrc

# INFO: Blank screen while downloading
RUN vim --not-a-term "+silent NeoBundleInstall" +qa && \
    vim --not-a-term "+silent GoInstallBinaries" +qa

COPY extras.zsh extras.zsh

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

COPY tmux.conf $HOME/.tmux.conf
RUN $HOME/.tmux/plugins/tpm/bin/install_plugins

RUN chown -R 1000:1000 $HOME
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
