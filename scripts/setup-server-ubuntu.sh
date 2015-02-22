#!/bin/bash
# bash <(curl -s https://raw.githubusercontent.com/webwatch-io/server-management/master/scripts/setup-server-ubuntu.sh)

#
# Globals
#

INSTALL_DIR="/opt/webwatch.io"
INSTALL_SUBDIR="server-management"
INSTALL_URL="https://github.com/webwatch-io/$INSTALL_SUBDIR.git"
INSTALL_USER="$USER"



#
# Begin supporting functions
#

function installGit {
  echo "Installing Git"
  dpkg -l | grep -qw git || sudo apt-get install -y git
}

function mkDirInstall {
  if [ ! -d "$INSTALL_DIR" ]; then
    echo "Creating $INSTALL_DIR"
    sudo mkdir -p "$INSTALL_DIR"
  else
    echo "$INSTALL_DIR already created"
  fi
  chown -R "$INSTALL_USER" "$INSTALL_DIR"
}

function installScripts {
  echo "Installing scripts"
  cd "$INSTALL_DIR"

  git_output=$(git init)

  if [[ "$git_output" == "Reinitialized"* ]]; then
    echo "Pulling latest scripts"
    cd "$INSTALL_SUBDIR" && \
    git pull
  else
    echo "Cloning scripts"
    git clone "$INSTALL_URL"
  fi

  find . -name "*.sh" | xargs chmod 744
}

function execSetupScripts {
  echo "Loading setup functions from $INSTALL_DIR/$INSTALL_SUBDIR/setupFunctions.sh"
  source "$INSTALL_DIR/$INSTALL_SUBDIR/setupFunctions.sh" || exit -1

  applyPatches
  initKeys
  addKey workstation_nimh.pub
  installApps
  setupSymlinks
  setProfile
}

function printCompletionMessage {
  echo "Script complete!"
}

function main {
  installGit
  mkDirInstall
  installScripts
  execSetupScripts
  printCompletionMessage
}


#
# Begin main body of script
#

main