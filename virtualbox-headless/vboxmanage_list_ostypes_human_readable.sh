#!/usr/bin/env bash
set -e

function vboxmanage_list_ostypes_human_readable () {
VBoxManage list ostypes | \
    sed -n \
        -e '/^ID/s/^[^:]\+:[[:blank:]]\+\(.*\)$/\1:              /g;' \
        -e '/^[^:]/s/^\(.\{17\}\).*$/\1/g;' \
        -e 'N;s/\nDescription:[[:blank:]]\+\(.*\)$/\1/g;' \
        -e 'N;s/\(.\+\)\n\Family ID:[[:blank:]]\+\(.*\)/\2 \1/p;' | \
    sort -V | \
    sed -e '1 s/^./ &/;' \
        -e '$!N;/^\([^ ]\+\) \(.*\)\n\1/! s/^\([^ ]\+\) \(.*\)\n\([^ ]\+\) \(.*\)/\1 \2\n \3 \4/;P;D;' | \
    sed -e 's/^[^ ]\+/   /g' \
        -e 's/^[[:blank:]]\([^ ]\+\) \(.*\)/\n \x1b[1;35;4;40m\1\x1b[0m\n    \2/g;' \
        -e "1 i \\\n\\x1b[0;33mVBoxManage list ostypes\\x1b[0m\n\n \x1b[0;34mVBoxManage ver.$(vboxmanage -v) supported <ostype>s:\\x1b[0m" \
        -e '$ a \\x1b[1;34m\n  In fact, you do not need to specify <ostype>, but doing so selects\n some sensible default values for certain VM parameters. For example,\n the RAM size and the type of the virtual network device.\n\x1b[0m'
}
vboxmanage_list_ostypes_human_readable


