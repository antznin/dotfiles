#
# Witekio
#

# Trixell - EZ3

alias_export trixez3 "/data/txl/md20xx"
alias_export tclient "$trixez3/client"
alias_export tws "$trixez3/workspace"
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

tshell ()
{
    cd "$tbuild" && BSP_DIR="$tbsp" make shell
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

alias_export etrixez14 "/data/txl/ez1"
alias_export eclient "$etrixez14/client"
alias_export ews "$etrixez14/workspace"
alias_export ebsp "$ews/wyld/bsp"
alias_export ebuild "$ebsp/build"
alias_export emisc "$ews/misc"
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
