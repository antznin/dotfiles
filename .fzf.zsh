# Setup fzf
# ---------
if [[ ! "$PATH" == */home/antznin/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/antznin/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/antznin/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/antznin/.fzf/shell/key-bindings.zsh"
