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

__colorized_output_lng="en"

declare -n __localization_dict=__colorized_output_str_$1

if [[ "${#__localization_dict[@]" == "0" ]] ; then
  __localization_dict=__colorized_output_str_en
fi

echo "Dict_length=${#__localization_dict[@]}"


#echo "${#${!'__colorized_output_str_'__colorized_output_lng}}"


#function info { echo -e "\e[32m[info] $*\e[39m"; }
#function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
#function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }

for sound in "${!__colorized_output_en[@]}"; do echo "$sound - ${__colorized_output_en[$sound]}"; done
