bindkey -v
bindkey "^?" backward-delete-char
bindkey '^q' my-backward-delete-word

setopt sharehistory
stty -ixon

ZSH_THEME="${ARG_THEME:-robbyrussell}"
RPROMPT=''
DISABLE_UNTRACKED_FILES_DIRTY="true"

export ZSH="$HOME/.oh-my-zsh"
export FZF_BASE="$HOME/.fzf"
export EDITOR='vim'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

plugins=(\
    git \
    zsh-autosuggestions \
    zsh-completions \
    colored-man-pages \
    fzf \
    zsh-z \
)

test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)

# Ctrl+Q to delete whole word
my-backward-delete-word () {
    local WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>|'
    zle backward-kill-word
}
zle -N my-backward-delete-word

source $ZSH/oh-my-zsh.sh

###########
# ALIASES #
###########

alias tldr="tldr -t base16"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias vimn="vim -c NERDTree"
alias grepr="grep -r"
alias python="python3"
alias d='dirs -v | head -10'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias df='df -x squashfs -x tmpfs -x devtmpfs'
alias walog='watch -n1 -t --color git alog'
alias llth="ll -t | head"
alias rf="readlink -f"
alias pduon="pduclient --hostname 192.168.1.100 --daemon localhost --port 1 -H --command on"
alias pduoff="pduclient --hostname 192.168.1.100 --daemon localhost --port 1 -H --command off"
alias bblaysr="bitbake-layers show-recipes"
alias bblaysl="bitbake-layers show-recipes"
alias bblaysa="bitbake-layers show-appends"
alias cdtemp="cd $(mktemp -d)"
alias gs="gst"
alias alert='notify-send -a alert --urgency=critical -i "$([ $? = 0 ] && echo terminal || echo error)"'
alias cwd="pwd | xclip -selection clipboard"
alias snooze="kill -SIGUSR1 $(pidof dunst)"
alias unsnooze="kill -SIGUSR2 $(pidof dunst)"
alias xc="xclip -selection clipboard"
alias setx="setxkbmap -option && setxkbmap -option caps:escape"
alias vactivate="source ./.venv/bin/activate"
alias g="git"
alias vim="nvim"
alias vi="nvim"

#####################
# Witekio shortcuts #
#####################

# FMU
alias  fmu="$HOME/dev/FullMetalUpdate/fullmetalupdate.perso"
export fmu="$HOME/dev/FullMetalUpdate/fullmetalupdate.perso"

# Trixell
alias  trix="/data/txl/md20xx"
export trix="/data/txl/md20xx"
alias  tws="$trix/workspace"
export tws="$trix/workspace"
alias  trepos="$tws/repos"
export trepos="$tws/repos"
alias  ttests="$tws/tests"
export ttests="$tws/tests"
alias  tbsp="$tws/wyld/bsp"
export tbsp="$tws/wyld/bsp"
alias  tbuild="$tws/wyld/build"
export tbuild="$tws/wyld/build"
alias  tdeploy="$tbuild/build/tmp/deploy"
export tdeploy="$tbuild/build/tmp/deploy"
alias  tlayers="$tbsp/sources"
export tlayers="$tbsp/sources"
alias  tmeta="$tlayers/custom/meta-txl"
export tmeta="$tlayers/custom/meta-txl"
alias  tkernelpatches="$tmeta/txl-bsp/recipes-kernel/linux/linux-xlnx"
export tkernelpatches="$tmeta/txl-bsp/recipes-kernel/linux/linux-xlnx"
alias  tkernelfragments="$tmeta/txl-bsp/recipes-kernel/linux/linux-xlnx/txl_kernel_fragments"
export tkernelfragments="$tmeta/txl-bsp/recipes-kernel/linux/linux-xlnx/txl_kernel_fragments"
tshell () {
    cd "$tbuild" && BSP_DIR="$tbsp" make shell
}
tmach () {
    cd "$tdeploy/images/$1"
}

# Morphosense
alias mmorph="/data/morphosense"
export mmorph="/data/morphosense"
alias mws="$mmorph/workspace"
export mws="$mmorph/workspace"
alias mbsp="$mws/bsp"
export mbsp="$mws/bsp"
alias mbuild="$mbsp/build"
export mbuild="$mbsp/build"
alias mwork="$mbuild/tmp/work"
export mwork="$mbuild/tmp/work"
alias mmach="$mws/bsp/build/tmp/deploy/images/morpho-gateway-v3"
export mmach="$mws/bsp/build/tmp/deploy/images/morpho-gateway-v3"
alias mlayers="$mbsp/layers"
export mlayers="$mbsp/layers"
alias mmeta="$mlayers/meta-morphosense"
export mmeta="$mlayers/meta-morphosense"
function mkasbuild () {
    env -C $mbsp kas build kas/user-specific.yml "$@"
}
function mkasshell () {
    env -C $mbsp kas shell kas/user-specific.yml
}

# Pluma
alias  plws="/work/data/pluma/tests"
export plws="/work/data/pluma/tests"

#############
# FUNCTIONS #
#############

function mkcd () {
	mkdir -p $1 && cd $1
}

function findf () {
    find . -type f -iname "*$1*"
}

function findd () {
    find . -type d -iname "*$1*"
}

function finda () {
    find . -iname "*$1*"
}

function treel () {
    tree -L $1
}

function im () {

    local conf="./conf/local.conf"
    cd $BUILDDIR;
    if [[ -e "$conf" ]]; then
        machine=$(grep -E "^MACHINE" $conf | tr -d '? ' | awk -F '=' '{print $2}' | tr -d '"')
    fi
    cd $BUILDDIR/tmp/deploy/images/$machine

}

function sb () {

    # eval exp="\$$1"

    # if [[ -d "$1" ]]; then
    #     source $1/../bsp/sources/standard/poky/oe-init-build-env $1/build
    # elif [[ -d "$exp" ]]; then
    #     source $exp/../bsp/sources/standard/poky/oe-init-build-env $exp/build
    # fi


    # cd $trix/witekio/workspace
    # make shell

    if [[ "$1" = "linwit" ]]; then

        export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE BSP_DIR"
        export BSP_DIR="$trix/witekio/bsp"

        . "$trix/witekio/bsp/buildtools/environment-setup-x86_64-pokysdk-linux"

        TEMPLATECONF=$trix/witekio/bsp/sources/custom/meta-txl/txl-bsp/conf \
            source $trix/witekio/bsp/sources/standard/poky/oe-init-build-env \
            $trix/witekio/workspace/build
    fi

}

function pvnc () {
    pv "$1" | nc -l -p 12345
}

# Yocto
function b () {
    cd "${BUILDDIR}/${1}"
}
function s () {
    cd "${BSP_DIR}/sources/${1}"
}
function w () {
    cd "${BUILDDIR}/../${1}"
}
function ws () {
    cd "${BUILDDIR}/workspace/sources/${1}"
}
function tmp () {
    cd "${BUILDDIR}/tmp/${1}"
}
function dep () {
    cd "${BUILDDIR}/tmp/deploy/${1}"
}

function rm_work_task () {
    bitbake -g "$1"
    bitbake -k -c rm_work $(cat pn-buildlist)
}

# vim the nth file listed in git status --short
function vimg () {
    local index="$1"

    if [[ "$index" == "" ]]; then
        index="1"
    elif [[ ! "$index" =~ [0-9]+ ]]; then
        printf "Index isn't a number\n"
        return
    fi
    
    file="$(git status --short \
        | awk '{$1=""; print $0}' \
        | head -$index | tail +$index \
        | xargs)" 

    vim "$file"
}

###########################
#  Shell startup control  #
###########################

# If currently in $linwit, execute sb linwit. Don't print anything
# [[ "`pwd`" =~ "`basename $linwit`" ]] && sb linwit > /dev/null && cd - > /dev/null
