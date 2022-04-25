#!/usr/bin/env bash
set -e

declare -a MISSING_PACKAGES

function info { echo -e "\e[32m[info] $*\e[39m"; }
function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }

command -v dpkg-deb > /dev/null 2>&1 || MISSING_PACKAGES+=("dpkg-deb")
command -v wget > /dev/null 2>&1 || MISSING_PACKAGES+=("wget")
command -v ar > /dev/null 2>&1 || MISSING_PACKAGES+=("binutils")
command -v tar > /dev/null 2>&1 || MISSING_PACKAGES+=("tar")
#command -v sudo > /dev/null 2>&1 || MISSING_PACKAGES+=("sudo")

if [ ! -z "${MISSING_PACKAGES}" ]; then
    warn "Are you sure you have DEBIAN-like system?"
    warn "Please, install and configure missing packages before running this script again."
    error "Missing: ${MISSING_PACKAGES[@]}"
fi

warn "Uninstalling Oracle VM VirtualBox Extension Pack to get latest version"
vboxmanage extpack cleanup
#VBoxManage list extpacks ;
#sleep 10 ;
VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"

info ""
info "Installing Oracle VM VirtualBox Extension Pack"
info ""

# Preparing for installation
cd ~
rm -rdf virtualbox-ext-pack*

# Download the latest extension metadata package
#apt-get download virtualbox-ext-pack |& \
#awk -v _vbep_="virtualbox-ext-pack" 'NR == 1{ 
#  
#  if ( $1 == "E:" )
#  { system ("echo ""APT download error: """$0);
#    exit 100;
#  }
#  else
#  { print"APT download complete: "_vbep_"_"$(NF-2)"_"$(NF-3)".deb";
#    system ("mkdir -p "_vbep_);
#    system ("ar vx "_vbep_"_"$(NF-2)"_"$(NF-3)".deb --output="_vbep_"/");
#  }
#  exit;
#}
#END{ if ( NR == 0 )
#  { system ("echo ""You MUST delete "_vbep_"\* files first!""");
#    exit 200;
#  }
#}' ;

# Simplifying the above logic
apt-get download virtualbox-ext-pack ;

#if [[ $? > 0 ]]; then
#    error "APT download error. Exiting."
#fi ;


# Creating temporary working directory
mkdir -p virtualbox-ext-pack ;

# Unpacking metadata package
ar vx $(ls virtualbox-ext-pack_*) --output=virtualbox-ext-pack/ ;
tar xvf virtualbox-ext-pack/control.tar.xz -C virtualbox-ext-pack/ ;

#if (( $? > 0 )); then
#    error "Unpacking failed. Exiting."
#fi

# List of files extracted
#ls virtualbox-ext-pack/

# Using headless editor to adjust installation script for silent installation
str_sed="$(echo ~)"
sed -i -e "s,/usr/share/v,${str_sed}/v,g" \
       -e "s,. /usr/share/debconf/confmodule,mkdir -p /usr/share/virtualbox-ext-pack ;,g" \
       virtualbox-ext-pack/postinst ;

# Viewing the result
#cat virtualbox-ext-pack/postinst ;

# Fire up installation
./virtualbox-ext-pack/postinst configure ;

# Cleanup
cd ~
rm -rdf virtualbox-ext-pack*
info "Installation and cleanup completed."
info ""



exit 0
