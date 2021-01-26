# Add all highlighting to zsh syntax hightlights
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# Smart case completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'
export PATH=$PATH:/home/tom/.powerline/scripts

################################################
# Colors
ESC_SEQ="\x1b["
RESET=$ESC_SEQ"39;49;00m"
RED=$ESC_SEQ"31;01m"
GREEN=$ESC_SEQ"32;01m"
YELLOW=$ESC_SEQ"33;01m"
BLUE=$ESC_SEQ"34;01m"
MAGENTA=$ESC_SEQ"35;01m"
CYAN=$ESC_SEQ"36;01m"

# Aliases
alias gs='git status'
alias gco='git checkout'

function agv()
{
    if [[ $@ == "" ]]; then
        last_ag=$(history | grep "^\s*[0-9]\+\s*ag" | tail -1 | sed 's/^\s*//' | cut -f3- -d" ")
        results=$(eval "$last_ag")
    else
        results=$(ag $@)
    fi
    if [[ "${results}" != "" ]]; then
        vim -c "setlocal buftype=nofile bufhidden=hide noswapfile" -c "let @/="'"'$@'"'" | set hls" - <<< "$results"
    else
        return -1
    fi
}

DEFAULT_ROOT_FILES=(pom.xml .git)
function t () {
	while :; do
		if [ $PWD = '/' ]; then
			return
		fi
		if [ -z $1 ]; then
			for DRF in "${DEFAULT_ROOT_FILES[@]}"; do
				if [ -e $DRF ]; then
					return
				fi
			done
		else
			if [ -e $1 ]; then
				return
			fi
		fi
		cd ../
	done
}

alias vi="vim"
export PATH=$PATH:/usr/local/go/bin/
