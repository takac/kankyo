Kankyo
------

Dockerised development environment!

Setup for Vim with plugins installed, Tmux with fancy status line, zsh with
oh-my-zsh with a set of plugins enabled.

To use, copy the `kankyo` script onto your `$PATH`.

```
sudo curl -o /usr/local/bin/kankyo https://raw.githubusercontent.com/takac/kankyo/master/kankyo
```

Then run `kankyo`, this will download and start the kankyo container. It will
start a zsh and tmux inside a alpine container. The `$PWD` of the workstation
will be mounted on `~/work`.

## Tools in Kankyo
- ZSH
    - oh-my-zsh
        - zsh-syntax-highlighting
        - docker
        - git
        - tmux
        - history-substring-search
- Vim
    - Shougo/neobundle.vim
    - chriskempson/base16-vim
    - peaksea
    - altercation/vim-colors-solarized.git
    - kien/rainbow_parentheses.vim
    - Yggdroot/indentLine
    - whatyouhide/vim-gotham
    - morhetz/gruvbox
    - bling/vim-airline
    - conradirwin/vim-bracketed-paste
    - godlygeek/tabular
    - Lokaltog/vim-easymotion
    - kien/ctrlp.vim
    - mhinz/vim-signify
    - rking/ag.vim
    - sjl/gundo.vim
    - chrisbra/sudoedit.vim
    - takac/vim-commandcaps
    - thinca/vim-quickrun
    - tpope/vim-commentary
    - tpope/vim-fugitive
    - tpope/vim-repeat
    - tpope/vim-rsi
    - tpope/vim-surround
    - vim-scripts/scratch.vim
    - wellle/targets.vim
    - fatih/vim-go
- Ag
- Git (with config setup from Dockerfile)
- Tmux with sexy status line (https://github.com/edkolev/tmuxline.vim)

### TODOs
- Mount ssh & config
- Persist .zsh_history
- Persist .vim history
- Mount gitconfig
- Move to golang 1.8
