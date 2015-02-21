#!/bin/bash
# bash <(curl -s https://raw.githubusercontent.com/webwatch-io/server-management/master/scripts/setup-server-ubuntu.sh)

#
# Globals
#

DIR_INSTALL="/opt/webwatch.io"
URL_INSTALL="https://github.com/webwatch-io/server-management.git"
USER_INSTALL="azureuser"



#
# Begin supporting functions
#

function installGit {
  echo "Installing Git"
  dpkg -l | grep -qw git || sudo apt-get install -y git
}

function mkDirInstall {
  if [ ! -d "$DIR_INSTALL" ]; then
    echo "Creating $DIR_INSTALL"
    mkdir -p "$DIR_INSTALL"
  else
    echo "$DIR_INSTALL already created"
  fi
  chown -R "$USER_INSTALL" "$DIR_INSTALL"
}

function installScripts {
  echo "Installing scripts"
  cd "$DIR_INSTALL"

  git_output=$(git init)

  if [[ "$git_output" == "Reinitialized"* ]]; then
    echo "Pulling latest scripts"
    cd check-management && \
    git pull
  else
    echo "Cloning scripts"
    git clone "$URL_INSTALL"
  fi
}

function printCompletionMessage {
  echo "Script complete!"
}

function main {
  installGit
  mkDirInstall
  installScripts
  printCompletionMessage
}


#
# Begin main body of script
#

main