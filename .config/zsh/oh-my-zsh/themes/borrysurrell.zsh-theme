# Load required modules
#
autoload -Uz vcs_info

# Set vcs_info parameters
#
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' formats "" " %{$fg_bold[blue]%}%s:(%{$reset_color%}%{$fg_bold[red]%}%b%{$reset_color%}%{$fg_bold[blue]%})%{$reset_color%}" "%%u%c"

# Fastest possible way to check if repo is dirty
#
git_dirty() {
    # Check if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    # Check if it's dirty
    command git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo " %F{yellow}✗%f"
}

# Display information about the current repository
#
repo_information() {
    echo "$vcs_info_msg_1_`git_dirty` $vcs_info_msg_2_%f"
}

# Displays the exec time of the last command if set threshold was exceeded
#
cmd_exec_time() {
    local stop=`date +%s.%N`
    local start=${cmd_timestamp:-$stop}
    local elapsed=$(echo "$stop - $start" | bc)
    local elapsed=$(printf "%.2f" "$elapsed" | tr ',' '.')
    local elapsed_sec=$(printf "%.0f" "$elapsed" | tr ',' '.')
    [ $elapsed_sec -gt 3 ] && echo " ${elapsed}s"
}

# Get the initial timestamp for cmd_exec_time
#
preexec() {
    cmd_timestamp=`date +%s.%N`
}

# Output additional information about paths, repos and exec time
#
precmd() {
    setopt localoptions nopromptsubst
    vcs_info # Get version control info before we start outputting stuff
    export PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} )%F{yellow}$(cmd_exec_time)%f %{$fg[cyan]%}%c%{$reset_color%}$(repo_information)"
    unset cmd_timestamp #Reset cmd exec time.
}
