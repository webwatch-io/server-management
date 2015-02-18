#!/bin/bash
# bash <(curl -s https://raw.githubusercontent.com/webwatch-io/server-management/master/setup-server-ubuntu.sh)


#
# Begin supporting functions
#

function applyPatches {
  echo Applying OS patches...
  sudo apt-get update && sudo apt-get -y upgrade
}

function addPublicKey {
  echo Adding public key: $1.pub
  curl -s https://raw.githubusercontent.com/webwatch-io/server-management/master/keys/$1.pub >> ~/.ssh/authorized_keys
}

function main {
  applyPatches
  addPublicKey workstation_nimh.pub
}


#
# Begin main body of script
#

main