#!/bin/bash
# Spawn a new instance of Wezterm using the CWD of the currently focused
# Wezterm process.
#
# This is useful in environment like i3 where terminals are opened using a
# key-combination while another terminal is already focused.
#
# If the script is run with a non-Alacritty window in focus or a non-compliant
# version of Wezterm, an instance will be spawned in the user's $HOME.

# Credit: https://github.com/Wezterm/Wezterm/issues/808#issuecomment-334200570.

# Prevent Wezterm from scaling.
export WINIT_X11_SCALE_FACTOR=1

ACTIVE_WINDOW=$(xdotool getactivewindow)
ACTIVE_WM_CLASS=$(xprop -id $ACTIVE_WINDOW | grep WM_CLASS)

echo ""

if [[ $ACTIVE_WM_CLASS == *"wezterm"* ]]
then
    # Get PID. If _NET_WM_PID isn't set, bail.
    PID=$(xprop -id $ACTIVE_WINDOW | grep _NET_WM_PID | grep -oP "\d+")
    if [[ "$PID" == "" ]]
    then
        wezterm start --always-new-process $@ &
    fi
    # Get first child of terminal
    CHILD_PID=$(pgrep -P $PID)
    if [[ "$PID" == "" ]]
    then
        wezterm start --always-new-process $@ &
    fi
    # Get current directory of child. The first child should be the shell.
    pushd "/proc/${CHILD_PID}/cwd"
    SHELL_CWD=$(pwd -P)
    popd
    # Start wezterm with the working directory
    wezterm start --always-new-process --cwd "$SHELL_CWD" $@ &
else
    wezterm start --always-new-process $@ &
fi
