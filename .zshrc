#!/usr/bin/env zsh

export ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.config/zsh/oh-my-zsh"
ZSH_THEME="borrysurrell"

plugins=(\
    colored-man-pages \
    git \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
fpath+="$HOME"/.config/zsh/completions

# # Speedups for oh-my-zsh
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"
# Smarter completion initialization
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi
# zsh-autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Init Oh My Zsh
source $ZSH/oh-my-zsh.sh

source "$HOME/.config/zsh/options.zsh"
source "$HOME/.config/zsh/exports.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/keymaps.zsh"
source "$HOME/.config/zsh/utils.zsh"
source "$HOME/.config/zsh/work.zsh"
source "$HOME/.config/zsh/wezterm.zsh"

# SSH Agent (keychain)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
