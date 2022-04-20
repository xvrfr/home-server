#!/usr/bin/env bash
set -e

declare -a MISSING_PACKAGES

function info { echo -e "\e[32m[info] $*\e[39m"; }
function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }

command -v dpkg-de1b > /dev/null 2>&1 || MISSING_PACKAGES+=("dpkg-deb")

if [ ! -z "${MISSING_PACKAGES}" ]; then
    error "Missing: ${MISSING_PACKAGES[@]}"
    warn "Are you sure you have DEBIAN-like system?"
    warn "Please, install and configure missing packages before running this script again."
fi
