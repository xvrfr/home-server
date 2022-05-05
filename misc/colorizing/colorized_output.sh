#!/usr/bin/env bash
set -e

echo "\$#=$#"
echo "\$1=$1"
echo "\$0=$0"

#source <(curl -sL "https://github.com/xvrfr/home-server/raw/main/misc/colorizing/showcolors16.sh")

function __colorized_output_localize {

  declare -A __colorized_output_str_en=(
    ["info"]="Info"
    ["warn"]="Warning"
    ["error"]="Error"
  )

  declare -A __colorized_output_str_ru=(
    ["info"]="Инфо"
    ["warn"]="Внимание"
    ["error"]="Ошибка"
  )

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


#function info { echo -e "\e[32m[info] $*\e[39m"; }
#function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
#function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }

#for sound in "${!__localization_dict[@]}"; do echo "$sound - ${__localization_dict[$sound]}"; done


__colorized_output_localize info ru
echo 994


