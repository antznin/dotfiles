#
# General config
#

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
    colored-man-pages \
    fd \
    fzf \
    git \
    zsh-autosuggestions \
    zsh-completions \
    zsh-syntax-highlighting \
    zsh-z \
)

test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)

# Ctrl+Q to delete whole word
my-backward-delete-word () {
    local WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>|'
    zle backward-kill-word
}

source $ZSH/oh-my-zsh.sh

# Movements with ALt-hjkl
bindkey '^[k' up-line-or-beginning-search
bindkey '^[j' down-line-or-beginning-search
bindkey '^[l' forward-word
bindkey '^[h' backward-word

#
# Aliases
#

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias alert='notify-send -a alert --urgency=critical -i "$([ $? = 0 ] && echo terminal || echo error)"'
alias bat="batcat"
alias batwalog='batwatch -n1 --command git alog'
alias bb="bitbake"
alias bblaysa="bitbake-layers show-appends"
alias bblaysl="bitbake-layers show-recipes"
alias bblaysr="bitbake-layers show-recipes"
alias cat="batcat"
alias cdtemp="cd $(mktemp -d)"
alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias cwd="pwd | xclip -selection clipboard"
alias d='dirs -v | head -10'
alias df='df -x squashfs -x tmpfs -x devtmpfs'
alias g="git"
alias gch="git checkout"
alias grepr="grep -r"
alias gres="git reset"
alias gs="gst"
alias gsts="git status --short"
alias llth="ll -t | head"
alias locksuspend="i3lock-fancy -g & sleep 5 && systemctl suspend"
alias pduoff="pduclient --hostname 192.168.1.100 --daemon localhost --port 1 -H --command off"
alias pduon="pduclient --hostname 192.168.1.100 --daemon localhost --port 1 -H --command on"
alias python="python3"
alias rf="readlink -f"
alias setx="setxkbmap -option && setxkbmap -option caps:escape"
alias snooze="kill -SIGUSR1 $(pidof dunst)"
alias tldr="tldr -t base16"
alias unsnooze="kill -SIGUSR2 $(pidof dunst)"
alias vactivate="source ./.venv/bin/activate"
alias vi="nvim"
alias vim="nvim"
alias vimf="vim +\"lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))\""
alias vimn="vim +NvimTreeOpen"
alias walog='watch -n1 -t --color git alog'
alias xc="xclip -selection clipboard"

#
# Witekio
#

# Can be used as `foobar` or `cd $foobar`
alias_export ()
{
    local name="$1"
    local path="$2"
    alias $name="$path"
    export $name="$path"
}

# Trixell EZ3
alias_export trixez3 "/data/txl/md20xx"
alias_export tclient "$trixez3/client"
alias_export tws "$trixez3/workspace"
alias_export trepos "$tws/repos"
alias_export ttests "$tws/tests"
alias_export tmisc "$tws/misc"
alias_export tbsp "$tws/wyld/bsp"
alias_export tbuild "$tws/wyld/build"
alias_export tsources "$tbuild/build/workspace/sources"
alias_export tdeploy "$tbuild/build/tmp/deploy"
alias_export tlayers "$tbsp/sources"
alias_export tpoky "$tbsp/sources/standard/poky/meta"
alias_export tmeta "$tlayers/custom/meta-txl"
alias_export tkernelpatches "$tmeta/txl-bsp/recipes-kernel/linux/linux-xlnx"
alias_export tkernelfragments "$tmeta/txl-bsp/recipes-kernel/linux/linux-xlnx/txl_kernel_fragments"

tshell ()
{
    cd "$tbuild" && BSP_DIR="$tbsp" make shell
}

tmach ()
{
    cd "$tdeploy/images/$1"
}

twd ()
{
    local pkg="$1"
    local num_pkg="$2"
    local num_version="$3"

    _yocto_wd "$tbuild/build/tmp/work" "$pkg" "$num_pkg" "$num_version"
}

# Trixell EZ1.4
alias_export etrixez14 "/data/txl/ez1"
alias_export eclient "$etrixez14/client"
alias_export ews "$etrixez14/workspace"
alias_export ebsp "$ews/wyld/bsp"
alias_export ebuild "$ebsp/build"
alias_export emisc "$ews/misc"
alias_export edeploy "$ebsp/build/tmp/deploy"
alias_export esources "$ews/wyld/bsp/sources"
alias_export emeta "$esources/custom/meta-txl"
alias_export epoky "$esources/standard/poky/meta"

eshell ()
{
    cd "$ebsp" \
        && TEMPLATECONF=/data/txl/ez1/workspace/wyld/bsp/sources/custom/meta-txl/txl-bsp/conf \
        source sources/standard/poky/oe-init-build-env ./build >/dev/null
}

emach ()
{
    cd "$edeploy/images/$1"
}

ewd ()
{
    local pkg="$1"
    local num_pkg="$2"
    local num_version="$3"

    _yocto_wd "$ebuild/tmp/work" "$pkg" "$num_pkg" "$num_version"
}

# Morphosense
alias_export mmorph "/data/morphosense"
alias_export mws "$mmorph/workspace"
alias_export mbsp "$mws/bsp"
alias_export mbuild "$mbsp/build"
alias_export mwork "$mbuild/tmp/work"
alias_export mmach "$mws/bsp/build/tmp/deploy/images/morpho-gateway-v3"
alias_export mlayers "$mbsp/layers"
alias_export mmeta "$mlayers/meta-morphosense"

function mkasbuild () {
    env -C $mbsp kas build kas/user-specific.yml "$@"
}

function mkasshell () {
    env -C $mbsp kas shell kas/user-specific.yml
}

# Pluma
alias_export plws "/data/pluma/tests"

#
# Functions
#

function mkcd () {
	mkdir -p "$1" && cd "$1"
}

# Not used anymore, using `fd`.
# function findf () { find . -type f -iname "*$1*" }
# function findd () { find . -type d -iname "*$1*" }
# function finda () { find . -iname "*$1*" }

function treel () {
    tree -L $1
}

function pvnc () {
    pv "$1" | nc -l -p 12345
}

function bbenv ()
{
    local recipe="$1"
    local variable="$2"

    if [ "$variable" = "" ]; then
        variable="$recipe"
        recipe=""
    fi

    bitbake -e $recipe | grep "^$variable="
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

# Search in a directory for given dir_name. Prompt if multiple matches.
# See _yocto_wd
function _search_and_prompt ()
{
    local search_dir="$1"
    local depth="$2"
    local dir_name="$3"
    local pre_select="$4"

    [[ -n "$dir_name" ]] \
        && found_dirs="$(find "$search_dir" -mindepth $depth -maxdepth $depth -name $dir_name -print)" \
        || found_dirs="$(find "$search_dir" -mindepth $depth -maxdepth $depth -print)"

    num_found="$(echo "$found_dirs" | wc -l)"

    if [[ "$num_found" = "1" ]]; then
        echo "$found_dirs"
        cd "$found_dirs"
    elif [[ "$num_found" -gt 1 ]]; then
        if [[ "$pre_select" = "" ]]; then
            for i in $(seq $num_found); do
                echo "$i: $(echo "${found_dirs//$search_dir\//}" | head -$i | tail +$i)"
            done
            read pre_select
        fi
        final_path="$(echo "$found_dirs" | head -$pre_select | tail +$pre_select)"
        echo "$(echo ${found_dirs//$search_dir\//} | head -$pre_select | tail +$pre_select)"
        cd "$final_path"
    fi
}

# Used to quickly cd to tmp/work/… working dir.
# See twd/ewd.
function _yocto_wd ()
{
    local workdir="$1"
    local pkg="$2"
    local num_pkg="$3"
    local num_version="$4"

    _search_and_prompt "$workdir" 2 "$pkg" "$num_pkg"
    _search_and_prompt "$(pwd)" 1 "" "$num_version"
}
