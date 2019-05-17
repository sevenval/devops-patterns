#!/usr/bin/env bash

# optionally set trace mode
[[ "$TRAP_COMMAND_TRACE" ]] && set -x

# Bash Strict Mode, s. http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Run trap only once.
function _trap () {
    set +u
    run="${run:-}"
    set -u
    local trap
    trap="$1"
    if [[ -z $run ]] ; then
        run=1
        eval "$trap"
    fi
}
Command="$1"
Trap="$2"

trap '_trap "$Trap"' ERR EXIT
eval "$Command"

# vim: ts=4 sw=4 expandtab ft=sh
