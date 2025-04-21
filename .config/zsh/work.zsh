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

export_and_add ...home "${DATA_ROOT}/..."

# Source per-project aliases and functions.
for key in ${(k)ALIAS_FUNCS}; do
    source "$ALIAS_FUNCS[$key]/config.zsh" || true
    export PATH="$ALIAS_FUNCS[$key]/scripts:$PATH"
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
