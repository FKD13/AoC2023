#!/bin/bash

day="$1"
part="$2"
input="$3"

source "${day}_code.sh"

PS4='+ $EPOCHREALTIME\011 '
exec 3>&2 2>/tmp/bashstart.$$.log
set -x

part_"$part" "$input"

set +x
exec 2>&3 3>&-
