#!/usr/bin/env bash

set -eu -o pipefail

echo whoami: $(whoami)

lock_prg="$(xrdb -query | grep -F 'i3-wm.program.lock:' | cut -f2)"

# bash -c "${lock_prg}"
$lock_prg
