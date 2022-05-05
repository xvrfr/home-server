#!/usr/bin/env bash
set -e

__script_baseurl="https://github.com/xvrfr/home-server/raw/main/misc/colorizing/"
__script_basename="colorized_output"
__script_baselang="en"

curl -sL  -H 'Cache-Control: no-cache' "https://github.com/xvrfr/home-server/raw/main/misc/translate.script_template" | \
cat | xargs



echo "\$#=$#"
echo "\$1=$1"
echo "\$0=$0"

#source <(curl -sL "https://github.com/xvrfr/home-server/raw/main/misc/colorizing/showcolors16.sh")

function __colorized_output_localize {

  source <(curl -sL "$__script_baseurl$__script_basename")


  __colorized_output_lng="en"

  declare -n __localization_dict=__colorized_output_str_${2,,}

  if [[ "${#__localization_dict[@]}" == "0" ]] ; then
    declare -n __localization_dict=__colorized_output_str_${__colorized_output_lng,,}
  fi

  __localization_key="${1,,}"

  if [[ "${__localization_dict[$__localization_key]}" == "" ]] ; then
    echo "$1"
  else echo "${__localization_dict[$__localization_key]}"
  fi

}

#echo "Dict_length=${#__localization_dict[@]}"
#echo "${#${!'__colorized_output_str_'__colorized_output_lng}}"

__colorized_output_localize info ru
echo 993

function info { echo -e "\e[32m[$(__colorized_output_localize info ru)] $*\e[39m"; }
#function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
#function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }

#for sound in "${!__localization_dict[@]}"; do echo "$sound - ${__localization_dict[$sound]}"; done

info "989"

