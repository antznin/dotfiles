#
# Utilities
#

alias_export ()
{
    local name="$1"
    local path="$2"
    alias $name="$path"
    export $name="$path"
}

mkcd ()
{
	mkdir -p "$1" && cd "$1"
}

benv ()
{
    local recipe="$1"
    local variable="$2"

    if [ "$variable" = "" ]; then
        variable="$recipe"
        recipe=""
    fi

    bitbake -e $recipe | grep "^$variable="
}

# vim the nth file listed in git status --short
function vimg () {
    local index="$1"

    if [[ "$index" == "" ]]; then
        index="1"
    elif [[ ! "$index" =~ [0-9]+ ]]; then
        printf "Index isn't a number\n"
        return
    fi

    file="$(git status --short \
        | awk "{$1=\"\"; print $0}" \
        | head -$index | tail +$index \
        | xargs)"

    vim "$file"
}

# Search in a directory for given dir_name. Prompt if multiple matches.
# See _yocto_wd
function _search_and_prompt ()
{
    local search_dir="$1"
    local depth="$2"
    local dir_name="$3"
    local pre_select="$4"

    [[ -n "$dir_name" ]] \
        && found_dirs="$(find "$search_dir" -mindepth $depth -maxdepth $depth -name $dir_name -print)" \
        || found_dirs="$(find "$search_dir" -mindepth $depth -maxdepth $depth -print)"

    num_found="$(echo "$found_dirs" | wc -l)"

    if [[ "$num_found" = "1" ]]; then
        echo "$found_dirs"
        cd "$found_dirs"
    elif [[ "$num_found" -gt 1 ]]; then
        if [[ "$pre_select" = "" ]]; then
            for i in $(seq $num_found); do
                echo "$i: $(echo "${found_dirs//$search_dir\//}" | head -$i | tail +$i)"
            done
            read pre_select
        fi
        final_path="$(echo "$found_dirs" | head -$pre_select | tail +$pre_select)"
        echo "$(echo ${found_dirs//$search_dir\//} | head -$pre_select | tail +$pre_select)"
        cd "$final_path"
    fi
}

# Used to quickly cd to tmp/work/… working dir.
# See twd/ewd.
function _yocto_wd ()
{
    local workdir="$1"
    local pkg="$2"
    local num_pkg="$3"
    local num_version="$4"

    _search_and_prompt "$workdir" 2 "$pkg" "$num_pkg"
    _search_and_prompt "$(pwd)" 1 "" "$num_version"
}
