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
vimg () {
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
# See yocto_wd
_search_and_prompt ()
{
    local search_dir="$1"
    local depth="$2"
    local dir_name="$3"
    local pre_select="$4"

    [[ -n "$dir_name" ]] \
        && found_dirs="$(find "$search_dir" -mindepth $depth -maxdepth $depth -name $dir_name -print)" \
        || found_dirs="$(find "$search_dir" -mindepth $depth -maxdepth $depth -print)"

    num_found="$(echo "$found_dirs" | wc -l)"

    if [[ -z "$found_dirs" ]]; then
        echo "No directory found."
        return 1
    fi

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
yocto_wd ()
{
    local workdir="$1"
    local pkg="$2"
    local num_pkg="$3"
    local num_version="$4"

    if [ -z "$workdir" ]; then
        echo "Working directory cannot be empty."
        return 1
    fi

    if [ -z "$pkg" ]; then
        echo "Package cannot be empty."
        return 1
    fi

    _search_and_prompt "$workdir" 2 "$pkg" "$num_pkg" \
        && _search_and_prompt "$(pwd)" 1 "" "$num_version"
}

bbenv ()
{
    local pn="$1"
    local var="$2"

    if [ "$#" = "1" ]; then
        pn=""
        var="$1"
    fi

    bitbake -e $pn | grep "^$var="
}

vim_last_output ()
{
    $(fc -ln -1) > /tmp/tmp.zsh_lst_cmd
    vim "$(cat /tmp/tmp.zsh_lst_cmd | fzf --layout reverse)"
}
zle -N vim_last_output
bindkey '^v' vim_last_output

ipklist ()
{
    local files="$*"

    tmpdir="$(mktemp -d)"
    for f in $files
    do
        # Extract data.tar.xz from ipk
        ar x --output "$tmpdir" "$f" data.tar.xz
        tar tvf "$tmpdir/data.tar.xz"
    done
    rm -r "$tmpdir"
}

ipkfind ()
{
    local deploydir="$1"
    local str="$2"

    find "$deploydir" -name "*.ipk" | while read ipk; do
        if ipklist "$ipk" | grep -q "$str"; then
            echo "$(basename "$ipk")"
        fi
    done
}
