#!/usr/bin/env bash
set -e

echo "\$#=$#"
echo "\$1=$1"
echo "\$0=$0"

declare -A __colorized_output_str_en=(
["info"]="Info"
["warn"]="Warning"
["error"]="Error"
)

#function info { echo -e "\e[32m[info] $*\e[39m"; }
#function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
#function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }

for sound in "${!__colorized_output_en[@]}"; do echo "$sound - ${__colorized_output_en[$sound]}"; done
