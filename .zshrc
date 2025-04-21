#!/usr/bin/env sh

if [ -f /usr/bin/liquidprompt ]; then
  export LP_PATH_LENGTH=15
  export LP_PATH_METHOD=truncate_chars_to_unique_dir
  source /usr/bin/liquidprompt
  source /usr/share/liquidprompt/themes/powerline/powerline.theme
  command -v lp_theme >/dev/null && lp_theme powerline
else
 ZSH_THEME="${ARG_THEME:-robbyrussell}"
fi

plugins=(\
    colored-man-pages \
    fzf \
    git \
    zsh-autosuggestions \
    zsh-bitbake \
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
source "$HOME/.config/zsh/wezterm.zsh"

# SSH Agent (keychain)
eval $(keychain --eval --quiet id_ed25519)
