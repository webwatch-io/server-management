#!/bin/bash
# bash <(curl -s https://raw.githubusercontent.com/webwatch-io/server-management/master/setup-server-ubuntu.sh)

#
# Begin globals
#

URI_ROOT=https://raw.githubusercontent.com/webwatch-io/server-management

#
# Begin supporting functions
#

function applyPatches {
  echo Applying OS patches...
  sudo apt-get update && sudo apt-get -y upgrade
}

function initKeys {
  echo Initialising authorized_keys file...
  echo "# File initialised at $(date)" > ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys
}

function addKey {
  echo Adding to authorized_keys: $URI_ROOT/master/keys/$1
  curl -s $URI_ROOT/master/keys/$1 >> ~/.ssh/authorized_keys
}

function setProfile {
  echo Setting Bash profile...
  curl -s $URI_ROOT/master/.bashrc > ~/.bashrc
  source ~/.bashrc
}

function main {
  applyPatches
  initKeys
  addKey workstation_nimh.pub
  setProfile
}


#
# Begin main body of script
#

main