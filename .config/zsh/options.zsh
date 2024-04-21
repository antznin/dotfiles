#
# Shell options
#

HISTFILE="$HOME/.zsh_history"
setopt sharehistory
stty -ixon

autoload -Uz select-word-style
select-word-style bash

# Enable direnv
eval "$(direnv hook zsh)"

#
# FZF options
#

# Initialize fzf
eval "$(fzf --zsh)"

# Theme: github light
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#656d76,bg:#ffffff,hl:#ffffff --color=fg+:#1F2328,bg+:#deeeff,hl+:#953800 --color=info:#9a6700,prompt:#0969da,pointer:#8250df --color=marker:#1a7f37,spinner:#24292f,header:#eff1f3'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    # ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

export BATDIFF_USE_DELTA=true

# Less history
export LESSHISTFILE="$HOME/.lesshst"

#
# fzf-tab
#

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
