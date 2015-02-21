# Set prompt to [time] user@host:/working_dir
export PS1="\n[\t] \$(uname) \[\e[01;33m\]\u@\H\[\e[0m\]:\[\e[00;32m\]\$PWD\[\e[0m\]\n\[\e[00;36m\]\$\[\e[0m\] "
export SUDO_PS1="$1"

# Set terminal title to user@hostname
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}\007"'