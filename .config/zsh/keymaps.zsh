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

delete-whole-word ()
{
    select-word-style shell
    zle backward-delete-word
    select-word-style bash
}
zle -N delete-whole-word
bindkey '^q' delete-whole-word
