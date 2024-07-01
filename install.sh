# To install:
#
# ssh config:
#   ssh-keygen -t ed25519
#   add key to github
#
# dotfiles:
#   git clone --bare $HOME/.dotfiles https://github.com/antznin/dotfiles.git
#   git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no
#   git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
#
# firefox
# keychain
# git
# base-devel
# yay (if manjaro)
# wezterm
# neovim
# direnv
# eza
# fzf
# git-delta
# bat
# npm  # for neovim
# direnv
# obsidian
# rofi
# unclutter
# zsh
# docker
# keepassxc
# ranger
# flameshot
# pamixer
# nm-applet
# pipewire-pulse
# xss-lock
# xclip
# dragon-drop
# xbacklight
# redshift
# fd
# ripgrep
# feh
# circumflex
# tspin
#
# thunderbird
# telegram-desktop
# teams
# slack-desktop
# tidal-hifi-bin
# syncthing
# transmission-qt
# vlc
# protonvpn
# blueman
# docker-buildx
#
# oh-my-zsh:
#
#   curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh >/tmp/install.sh
#   chmod +x /tmp/install.sh
#   /tmp/install.sh --skip-chsh --unattended --keep-zshrc
#   rm /tmp/install.sh
#
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
#   $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions \
#   $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-completions \
#   $HOME/.oh-my-zsh/custom/plugins/zsh-completions
# git clone https://github.com/antznin/zsh-bitbake \
#   $HOME/.oh-my-zsh/custom/plugins/zsh-bitbake
# git clone https://github.com/Aloxaf/fzf-tab \
#   $HOME/.oh-my-zsh/custom/plugins/fzf-tab
#
# Install qwerty-antznin, and: TODO
# localectl set-x11-keymap fr pc105 antznin caps:escape
#
# Natural scrolling:
# /etc/X11/xorg.conf.d/30-touchpad.conf:
#
# Section "InputClass"
#     Identifier "touchpad"
#     Driver "libinput"
#     MatchIsTouchpad "on"
#     Option "Tapping" "on"
#     NaturalScrolling "true"
# EndSection
#
# sudo systemctl enable docker
# sudo systemctl start docker
# sudo usermod -aG docker $USER
#
# neovim:
#   mason:
#     shellcheck
#     oelint-adv
#     bash-language-server
#     flake8
#
# configure syncthing:
# systemctl --user enable syncthing.service
# systemctl --user start syncthing.service
#
# reboot
#
# systemctl --user enable pipewire-pulse
# systemctl --user start pipewire-pulse
#
# Remove quiet from boot parameters:
# Edit /etc/default/grub: remove quiet from GRUB_CMDLINE_LINUX_DEFAULT
# grub-mkconfig -o /boot/grub/grub.cfg
#
# Bluetooth: modprobe snd_seq to make headphones work?
# /etc/modules-load.d/snd_seq.conf:
#   # Load snd_seq module on boot for BT audio
#   snd_seq
#
# Refresh mirrorlist:
#   systemctl enable pamac-mirrorlist.timer
#
# xdg-settings set default-web-browser firefox.desktop
#
# misc:
#
#   git maintenance start
#
#   misc:
#
#     git maintenance start
