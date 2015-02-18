#!/bin/bash
# bash <(curl -s https://raw.githubusercontent.com/webwatch-io/server-management/master/setup-server-ubuntu.sh)


#
# Begin supporting functions
#

function applyPatches {
  echo Applying OS patches...
  sudo apt-get update && sudo apt-get -y upgrade
}

function initKeys {
  echo Initialising authorized_keys file...
  echo > ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys
}

function addKey {
  echo Adding to authorized_keys: $1
  curl -s https://raw.githubusercontent.com/webwatch-io/server-management/master/keys/$1 >> ~/.ssh/authorized_keys
}

function main {
  applyPatches
  initKeys
  addKey workstation_nimh.pub
}


#
# Begin main body of script
#

main