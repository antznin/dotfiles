#
# Work configuration
#

typeset -A ALIAS_FUNCS=()

function export_and_add ()
{
    local name="$1"
    local path="$2"

    ALIAS_FUNCS[$name]="$path"
    export $name="$path"
    compdef "_custom_dir_list $path" $name
}

DATA_ROOT="/data"

#
# Projects
#

export_and_add t3home "${DATA_ROOT}/txl/md20xx"
export_and_add shome "${DATA_ROOT}/sonendo"
export_and_add ehome "${DATA_ROOT}/etc"

# Source per-project aliases and functions.
for key in ${(k)ALIAS_FUNCS}; do
    source "$ALIAS_FUNCS[$key]/config.zsh" || true
done

#
# Create functions from ALIAS_FUNCS array
#

for key in ${(k)ALIAS_FUNCS}; do
    function $key () {
        local extra_path="$1"
        cd $ALIAS_FUNCS[$0]"/$extra_path"
    }
done
