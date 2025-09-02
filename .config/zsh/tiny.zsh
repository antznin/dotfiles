# This is a tiny zsh configuration file to use on servers/containers and such.

export ZSH="$HOME/.oh-my-zsh"

if command -v nvim >/dev/null; then
  export EDITOR="nvim"
elif command -v vim >/dev/null; then
  export EDITOR="vim"
else
  export EDITOR="vi"
fi

ZSH_THEME="robbyrussell"

plugins=(\
  git \
  zsh-syntax-highlighting \
  zsh-autosuggestions \
  zsh-completions \
  zsh-bitbake \
)

source $ZSH/oh-my-zsh.sh

# Enable direnv
eval "$(direnv hook zsh)"

bindkey "^h" backward-word
bindkey "^j" down-line-or-beginning-search
bindkey "^k" up-line-or-beginning-search
bindkey "^l" forward-word
bindkey "^[h" backward-char
bindkey "^[l" forward-char
bindkey "^[a" clear-screen

# use the vi navigation keys in menu completion
zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

alias 1="cd -"
alias 2="cd -2"
alias 3="cd -3"
alias 4="cd -4"
alias 5="cd -5"
alias 6="cd -6"
alias 7="cd -7"
alias 8="cd -8"
alias 9="cd -9"
alias alert="notify-send -a alert --urgency=critical -i \"$([ $? = 0 ] && echo terminal || echo error)\""
alias b4s="b4 shazam -s"
alias b4td="b4 ty -d"
alias b4tl="b4 ty -l"
alias b4-presend="rm -rf /tmp/presend && mkdir -p /tmp/presend && b4 send --no-sign -o /tmp/presend && ( cd /tmp/presend && nvim -c 'bufdo set filetype=gitsendemail' *.eml )"
alias bb="bitbake"
alias bblaysa="bitbake-layers show-appends"
alias bblaysl="bitbake-layers show-recipes"
alias bblaysr="bitbake-layers show-recipes"
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias cwd="pwd | xclip -selection clipboard"
alias d="dirs -v | head -10"
alias df="df -x squashfs -x tmpfs -x devtmpfs"
alias fd="fd --color=always"
alias g="git"
alias gitignore="git update-index --assume-unchanged"
alias gitfollow="git update-index --no-assume-unchanged"
alias gch="git checkout"
alias gcps="git cherry-pick -x -s"
alias grepr="grep -r"
alias gres="git reset"
alias gs="gst"
alias gsts="git status --short"
alias l="exa --git -la"
alias ll="exa --git -l"
alias ls="exa --git"
alias locksuspend="i3lock-fancy -g & sleep 5 && systemctl suspend"
alias nt="nautilus"
alias pacman-leftovers="pacman -Qdtq"
alias pduoff="pduclient --hostname 192.168.1.100 --daemon localhost --port 1 -H --command off"
alias pduon="pduclient --hostname 192.168.1.100 --daemon localhost --port 1 -H --command on"
alias python="python3"
alias ra="ranger"
# alias rga="rg --no-ignore"
alias setx="setxkbmap -option && setxkbmap -option caps:escape"
alias snooze="kill -SIGUSR1 $(pidof dunst)"
alias tldr="tldr -t base16"
alias turnoffgit="git config --add oh-my-zsh.hide-status 1 && git config --add oh-my-zsh.hide-dirty 1"
alias unsnooze="kill -SIGUSR2 $(pidof dunst)"
alias v="nvim"
alias vactivate="source ./.venv/bin/activate"
alias vi="nvim"
alias vim="nvim"
alias vimf="vim +\"lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))\""
alias vimn="vim +NvimTreeOpen"
alias walog="watch -n1 -t --color git alog"
alias xc="xclip -rmlastnl -selection clipboard"
