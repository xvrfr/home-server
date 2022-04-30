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
echo 1
__colorized_output_lng="en"

declare -n __localization_dict=__colorized_output_str_$1
echo 3
if [[ "${#__localization_dict[@]}" == "0" ]] ; then
  echo 31
  __localization_dict=__colorized_output_str_en
  echo 32
fi
echo 4
echo "Dict_length=${#__localization_dict[@]}"
echo 5

#echo "${#${!'__colorized_output_str_'__colorized_output_lng}}"


#function info { echo -e "\e[32m[info] $*\e[39m"; }
#function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
#function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }

for sound in "${!__colorized_output_en[@]}"; do echo "$sound - ${__colorized_output_en[$sound]}"; done
