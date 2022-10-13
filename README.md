# dotfiles

> Configuration files in my home directory.

## Install


* Initialize:

  ```
  git init --bare $HOME/.dotfiles
  git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no
  ```

* Clone:

  ```
  git clone --bare $HOME/.dotfiles
  git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no
  git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
  ```

Command `config` is aliased to `git --git-dir=$HOME/.dotfiles
--work-tree=$HOME`. To add, commit, push… use `config add …`, `config commit
…`, etc.
