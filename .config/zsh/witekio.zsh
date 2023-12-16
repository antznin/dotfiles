#
# Witekio
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

# Trixell - EZ3

export_and_add trixez3 "${DATA_ROOT}/txl/md20xx"
export_and_add tclient "$trixez3/client"
export_and_add tws "$trixez3/workspace"
export_and_add tdocker "$trixez3/docker"
export_and_add trepos "$tws/repos"
export_and_add ttests "$tws/tests"
export_and_add tmisc "$tws/misc"
export_and_add tbsp "$tws/wyld/bsp"
export_and_add tbuild "$tws/wyld/build"
export_and_add tsources "$tbuild/build/workspace/sources"
export_and_add tdeploy "$tbuild/build/tmp/deploy"
export_and_add tlayers "$tbsp/sources"
export_and_add tpoky "$tbsp/sources/standard/poky/meta"
export_and_add tmeta "$tlayers/custom/meta-txl"
export_and_add tkernelpatches "$tmeta/txl-bsp/recipes-kernel/linux/linux-xlnx"
export_and_add tkernelfragments "$tmeta/txl-bsp/recipes-kernel/linux/linux-xlnx/txl_kernel_fragments"

yocto_build_mode="container-yocto"

tshell()
{
    local yocto_version="${1:-kirkstone}"

    pushd $trixez3/docker >/dev/null
    make run CONTAINER_CMD="$tws/entrypoint.sh $yocto_version"
    popd >/dev/null
}

tmach ()
{
    cd "$tdeploy/images/$1"
}

twd ()
{
    local pkg="$1"
    local num_pkg="$2"
    local num_version="$3"

    yocto_wd "$tbuild/build/tmp/work" "$pkg" "$num_pkg" "$num_version"
}

# J&J

export_and_add jhome "${DATA_ROOT}/jandj"
export_and_add jclient "$jhome/client"
export_and_add jws "$jhome/workspace"
export_and_add jbsp "$jws/bsp"
export_and_add jbuild "$jbsp/build"
export_and_add jmeta "$jbsp/meta-otx"
export_and_add jkpatches "$jmeta/recipes-kernel/linux/files"
export_and_add jpoky "$jbsp/poky"
export_and_add jdeploy "$jbuild/tmp/deploy"
export_and_add jmach "$jdeploy/images/rcu"

jwd ()
{
    local pkg="$1"
    local num_pkg="$2"
    local num_version="$3"

    yocto_wd "$jbuild/tmp/work" "$pkg" "$num_pkg" "$num_version"
}

# Sonendo

export_and_add shome "${DATA_ROOT}/sonendo"
export_and_add sdocker "${shome}/docker"
export_and_add sclient "$shome/client"
export_and_add sws "$shome/workspace"
export_and_add sbsp "$sws/bsp"
export_and_add sbuild "$sbsp/build"
export_and_add ssources "$sbsp/sources"
export_and_add spoky "$ssources/poky"
export_and_add smeta "$ssources/meta-sonendo"
export_and_add spoky "$ssources/poky"
export_and_add sdeploy "$sbuild/tmp/deploy"
export_and_add smach "$sdeploy/images/nitrogen8m"

function sshell()
{
    local yocto_version="${1:-kirkstone}"

    pushd $shome/docker >/dev/null
    git checkout ${yocto_version}-sonendo
    direnv allow .
    make run CONTAINER_CMD="$sws/entrypoint.sh $yocto_version"
    popd >/dev/null
}

function swd ()
{
    local pkg="$1"
    local num_pkg="$2"
    local num_version="$3"

    yocto_wd "$sbuild/tmp/work" "$pkg" "$num_pkg" "$num_version"
}

# ETC

source $HOME/.config/zsh/private/etc.zsh

export_and_add ehome "${DATA_ROOT}/etc"
export_and_add edocker "$ehome/docker"
export_and_add eclient "$ehome/client"
export_and_add emisc "$ehome/misc"
export_and_add ews "$ehome/ws"
export_and_add erepos "$ews/repos"
export_and_add ebsp "$ews/bsp/cccp-yocto-images"
export_and_add ebuild "$ebsp/build"
export_and_add esources "$ebsp/yocto-layers"
export_and_add epoky "$esources/poky"
export_and_add emeta "$ebsp/cccp-layers/meta-cccp"
export_and_add ekernelpatches "$emeta/recipes-kernel/linux/linux-qoriq/mickledore"
export_and_add epoky "$esources/poky"
export_and_add edeploy "$ebuild/tmp/deploy"
export_and_add emach "$edeploy/images/balakovo"

function eshell()
{
    local default_cmd
    default_yocto_cmd='TEMPLATECONF="/data/etc/ws/bsp/cccp-yocto-images/cccp-layers/meta-cccp/conf/templates/balakovo-cccp" . /data/etc/ws/bsp/cccp-yocto-images/yocto-layers/poky/oe-init-build-env build'

    local yocto_version="${1:-cccp-yocto-images}"
    local yocto_cmd="${2:-$default_yocto_cmd}"

    pushd $edocker >/dev/null
    git checkout ${yocto_version}-base
    direnv allow .
    make run CONTAINER_CMD="$ews/entrypoint.sh \"$yocto_version\" \"$yocto_cmd\""
    popd >/dev/null
}

function ewd ()
{
    local pkg="$1"
    local num_pkg="$2"
    local num_version="$3"

    yocto_wd "$ebuild/tmp/work" "$pkg" "$num_pkg" "$num_version"
}

# Misc

replace_files ()
{
    for f in $@
    do
        dest="$(echo "$f" | sed 's/v1.6.0-txl//')"
        dest="v1.7.0-txl$dest"
        cp -v "$f" "$dest"
    done
}

replace_dir ()
{
    dest="$(echo "$1" | sed 's/v1.6.0-txl//')"
    dest="v1.7.0-txl$dest"
    dest="$(dirname "$dest")"
    cp -rv "$1" "$dest"
}

revert ()
{
    for f in $@
    do
        dest="$(echo "$f" | sed 's/v1.7.0-txl.bak//')"
        dest="v1.7.0-txl$dest"
        cp -v "$f" "$dest"
    done
}

#
# Export and make funcs from ALIAS_FUNCS array
#

for key in ${(k)ALIAS_FUNCS}; do
    function $key () {
        local extra_path="$1"
        cd $ALIAS_FUNCS[$0]"/$extra_path"
    }
done
