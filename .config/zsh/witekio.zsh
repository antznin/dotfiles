#
# Witekio
#

DATA_ROOT="/data"

# Trixell - EZ3

alias_export trixez3 "${DATA_ROOT}/txl/md20xx"
alias_export tclient "$trixez3/client"
alias_export tws "$trixez3/workspace"
alias_export tdocker "$trixez3/docker"
alias_export trepos "$tws/repos"
alias_export ttests "$tws/tests"
alias_export tmisc "$tws/misc"
alias_export tbsp "$tws/wyld/bsp"
alias_export tbuild "$tws/wyld/build"
alias_export tsources "$tbuild/build/workspace/sources"
alias_export tdeploy "$tbuild/build/tmp/deploy"
alias_export tlayers "$tbsp/sources"
alias_export tpoky "$tbsp/sources/standard/poky/meta"
alias_export tmeta "$tlayers/custom/meta-txl"
alias_export tkernelpatches "$tmeta/txl-bsp/recipes-kernel/linux/linux-xlnx"
alias_export tkernelfragments "$tmeta/txl-bsp/recipes-kernel/linux/linux-xlnx/txl_kernel_fragments"

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

# Trixell EZ1.4

alias_export etrixez14 "${DATA_ROOT}/txl/ez1"
alias_export eclient "$etrixez14/client"
alias_export ews "$etrixez14/workspace"
alias_export ebsp "$ews/wyld/bsp"
alias_export ebuild "$ebsp/build"
alias_export emisc "$ews/misc"
alias_export erepos "$ews/repos"
alias_export edeploy "$ebsp/build/tmp/deploy"
alias_export esources "$ews/wyld/bsp/sources"
alias_export emeta "$esources/custom/meta-txl"
alias_export epoky "$esources/standard/poky/meta"

eshell ()
{
    cd "$ebsp" && BSP_DIR="$ebsp" make shell
}

emach ()
{
    cd "$edeploy/images/$1"
}

ewd ()
{
    local pkg="$1"
    local num_pkg="$2"
    local num_version="$3"

    yocto_wd "$ebuild/tmp/work" "$pkg" "$num_pkg" "$num_version"
}

flash_ez14 ()
{
    local suffix="$1"

    set -x

    lsblk /dev/sdez
    read
    sudo umount /dev/sdezp[0-9]
    sleep 1
    sudo dd if="$edeploy/images/txl-ez1-4/txl-image${suffix}-txl-ez1-4.txl-sdimg" of=/dev/sdez bs=1M
}

# J&J

alias_export jhome "${DATA_ROOT}/jandj"
alias_export jclient "$jhome/client"
alias_export jws "$jhome/workspace"
alias_export jbsp "$jws/bsp"
alias_export jbuild "$jbsp/build"
alias_export jmeta "$jbsp/meta-otx"
alias_export jkpatches "$jmeta/recipes-kernel/linux/files"
alias_export jpoky "$jbsp/poky"
alias_export jdeploy "$jbuild/tmp/deploy"
alias_export jmach "$jdeploy/images/rcu"

jwd ()
{
    local pkg="$1"
    local num_pkg="$2"
    local num_version="$3"

    yocto_wd "$jbuild/tmp/work" "$pkg" "$num_pkg" "$num_version"
}

# Sonendo

alias_export shome "${DATA_ROOT}/sonendo"
alias_export sdocker "${shome}/docker"
alias_export sclient "$shome/client"
alias_export sws "$shome/workspace"
alias_export sbsp "$sws/bsp"
alias_export sbuild "$sbsp/build"
alias_export ssources "$sbsp/sources"
alias_export spoky "$ssources/poky"
alias_export smeta "$ssources/meta-sonendo"
alias_export spoky "$ssources/poky"
alias_export sdeploy "$sbuild/tmp/deploy"
alias_export smach "$sdeploy/images/nitrogen8m"

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
