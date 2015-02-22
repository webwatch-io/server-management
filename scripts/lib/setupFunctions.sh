#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/globals.sh || exit -1

#
# Begin supporting functions
#

function applyPatches {
  echo "Applying OS patches"
  sudo apt-get update
  sudo apt-get -y upgrade
  sudo apt-get -y autoremove
}

function initKeys {
  echo "Initialising authorized_keys file"
  echo "# File initialised at $(date)" > ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys
}

function addKey {
  echo "Adding to authorized_keys: $URL_INSTALL_SERVER_MANAGEMENT_RAW/master/keys/$1"
  curl -s $URL_INSTALL_SERVER_MANAGEMENT_RAW/master/keys/$1 >> ~/.ssh/authorized_keys
}

function installApp {
  echo "Installing app: $1"
  sudo apt-get -y install $1
}

function installServerCheckManagement {
  echo "Checking install directory exists: $DIR_INSTALL"
  [ -d "$DIR_INSTALL" ] || exit -1

  if [ -d "$DIR_INSTALL_CHECK_MANAGEMENT" ]; then
    echo "$DIR_INSTALL_CHECK_MANAGEMENT already exists, so pulling updates from $DIR_INSTALL_CHECK_MANAGEMENT"
    cd "$DIR_INSTALL_CHECK_MANAGEMENT"
    git pull
  else
    echo "Cloning $DIR_INSTALL_CHECK_MANAGEMENT into $DIR_INSTALL_CHECK_MANAGEMENT"
    git clone "$URL_INSTALL_CHECK_MANAGEMENT"
  fi
}

function installApps {
  echo "Installing apps"
  installApp nodejs
  installApp npm
  installServerCheckManagement
}

function setupSymlink {
  if [ ! -f "$2" ]; then
    echo "Setting up symlink: $2->$1"
    sudo ln -s /usr/bin/nodejs /usr/bin/node
  else
    echo "Skipping creation of symlink for $2->$1 as $2 already exists"
    ls -l "$2"
  fi
}

function setupSymlinks {
  echo "Setting up symlinks"
  setupSymlink "/usr/bin/nodejs" "/usr/bin/node"
}

function setProfile {
  echo "Setting Bash profile"
  curl -s $URL_INSTALL_SERVER_MANAGEMENT_RAW/master/misc/.bashrc > ~/.bashrc
}