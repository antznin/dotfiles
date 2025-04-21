#
# Utilities
#

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

rf ()
{
    local file="$1"

    readlink -f "$file" | xc
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
    local pattern="${3:-*.ipk}"

    find "$deploydir" -name "$pattern" | while read ipk; do
        if ipklist "$ipk" | grep -q "$str"; then
            echo "$(basename "$ipk")"
        fi
    done
}

rpmlist ()
{
    local files="$*"

    for f in $files
    do
        rpm -ql "$f"
    done
}

rpmfind ()
{
    local deploydir="$1"
    local str="$2"

    find "$deploydir" -name "*.rpm" | while read rpm; do
        if rpmlist "$rpm" | grep -q "$str"; then
            echo "$(basename "$rpm")"
        fi
    done
}

bbv ()
{
    local var="$1"
    local recipe="$2"
    local flag="$3"

    [ -n "$recipe" ] && recipe="-r $recipe"
    [ -n "$flag" ] && flag="-f $flag"

    bitbake-getvar $var $recipe $flag
}

ggs ()
{
  local text="$*"

  sha="$(git log --oneline --format="%h %s" | grep -F "$text" | head -1 | awk '{print $1}')"

  [ -n "$sha" ] && git show "$sha"
}

b4test ()
{
  local message_id="$1"
  shift
  local command="$*"
  local random_name="$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo)"

  git checkout -b "$random_name"
  b4 shazam --sloppy-trailers --no-add-trailers "$message_id"
  eval "$command" || true
  git switch - 2>/dev/null || git switch --detach -
  git branch -D "$random_name"
}

gitf ()
{
  local sha="$1"
  git --no-pager log --abbrev=12 -1 --pretty='%h ("%s")' "$sha"
}

lesspatches ()
{
  LESSOPEN='||cat %s | delta --true-color always' less "$@"
}

