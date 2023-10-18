#
# Zsh keymaps
#

bindkey "^h" backward-word
bindkey "^j" down-line-or-beginning-search
bindkey "^k" up-line-or-beginning-search
bindkey "^l" forward-word
bindkey "^[h" backward-char
bindkey "^[l" forward-char
bindkey "^[a" clear-screen

zstyle ':completion:*' menu select
zmodload zsh/complist

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
