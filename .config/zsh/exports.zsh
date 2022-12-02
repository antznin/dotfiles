#
# Export variables
#

export EDITOR="nvim"

# Auto suggestions
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)

# Faster oh-my-zsh git
export DISABLE_UNTRACKED_FILES_DIRTY="true"

# Fzf
export FZF_BASE="$HOME/.fzf"
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
