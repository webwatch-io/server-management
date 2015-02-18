# Enable color prompt
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    color_prompt=
fi

# Set prompt to [time] user@host:/working_dir
if [ "$color_prompt" = yes ]; then
    export PS1="\n[\t] \[\e[01;33m\]\u@\H\[\e[0m\]:\[\e[00;32m\]\$PWD\[\e[0m\]\n\[\e[00;36m\]\$\[\e[0m\] "
    export SUDO_PS1="\n[\t] \[\e[33;01;41m\]\u@\H\[\e[0m\]:\[\e[00;32m\]\$PWD\[\e[0m\]\n[\e[00;36m\]\$\[\e[0m\] "
else
    export PS1="\n[\t] \u@\H:\$PWD\n\$ "
fi