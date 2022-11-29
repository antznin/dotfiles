#!/usr/bin/env sh

# Zap plugin manager
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Remote
plug "zap-zsh/supercharge" # Better coloring, etc
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-completions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/zap-prompt" # Good looking prompt.
plug "zap-zsh/fzf"
plug "zap-zsh/exa"
sub_plug "ohmyzsh/ohmyzsh" "master" "git" "plugins/git"

# Local
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/options.zsh"
plug "$HOME/.config/zsh/keymaps.zsh"
plug "$HOME/.config/zsh/utils.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/witekio.zsh"
