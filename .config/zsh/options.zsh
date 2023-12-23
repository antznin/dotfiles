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
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

export BATDIFF_USE_DELTA=true

# Less history
export LESSHISTFILE="$HOME/.lesshst"

# Show indicator on the bottom right of the terminal when completing
zmodload zsh/terminfo

function set_completion_indicator {
  echoti sc # save_cursor
  echoti cup $((LINES - 1)) $((COLUMNS - $#1)) # cursor_position (bottom right)
  echoti setaf "$2" # set_foreground (color)
  printf %s "$1"
  echoti sgr 0 # exit_attribute_mode
  echoti rc # restore_cursor
}

completion_wait_text="completing..."
function display_completion_indicator {
  compprefuncs+=(display_completion_indicator)
  set_completion_indicator $completion_wait_text 3 # yellow
}

function hide_completion_indicator {
  comppostfuncs+=(hide_completion_indicator)
  # Kind of hack here, we print whitespaces to erase the text.
  set_completion_indicator ${completion_wait_text//?/ } 0
}

compprefuncs+=(display_completion_indicator)
comppostfuncs+=(hide_completion_indicator)
