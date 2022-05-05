#!/usr/bin/env bash
#set -e

__script_baseurl="https://github.com/xvrfr/home-server/raw/main/misc/colorizing/"
__script_basename="colorized_messaging"
__script_baselang="en"

source <(curl -sL "https://github.com/xvrfr/home-server/raw/main/misc/translate.script_template")
__script_setlang_func="__localize_dict_$__script_basename"
$__script_setlang_func ru

function info { echo -e "\e[32m[$(__localize_$__script_basename info)] $*\e[39m"; }
#function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
#function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }

#for sound in "${!__localization_dict[@]}"; do echo "$sound - ${__localization_dict[$sound]}"; done

info "984"

