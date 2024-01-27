#!/usr/bin/env sh

ZSH_THEME="${ARG_THEME:-robbyrussell}"

plugins=(\
    colored-man-pages \
    fd \
    fzf \
    git \
    zsh-autosuggestions \
    zsh-bitbake \
    zsh-completions \
    zsh-syntax-highlighting \
    z \
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Oh My zsh
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Custom completion directory
fpath+="$HOME"/.config/zsh/completions
autoload -U compinit
compinit

source "$HOME/.config/zsh/options.zsh"
source "$HOME/.config/zsh/exports.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/keymaps.zsh"
source "$HOME/.config/zsh/utils.zsh"
source "$HOME/.config/zsh/work.zsh"

# SSH Agent (keychain)
eval $(keychain --eval --quiet id_ed25519)
