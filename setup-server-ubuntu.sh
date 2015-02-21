#!/bin/bash
# bash <(curl -s https://raw.githubusercontent.com/webwatch-io/server-management/master/setup-server-ubuntu.sh)

#
# Begin globals
#

URI_ROOT="https://raw.githubusercontent.com/webwatch-io/server-management"

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

function installApp {
  echo Installing $1...
  sudo apt-get -y install $1
}

function installApps {
  echo Installing apps...
  installApp nodejs
  installApp npm
}

function setProfile {
  echo Setting Bash profile...
  curl -s $URI_ROOT/master/.bashrc > ~/.bashrc
}

function end {
  echo "All done!"
}

function main {
  applyPatches
  initKeys
  addKey workstation_nimh.pub
  installApps
  setProfile
  end
}


#
# Begin main body of script
#

main