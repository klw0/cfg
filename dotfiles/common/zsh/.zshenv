#
# Defines environment variables.
#

# Set up the path
if [[ -x /usr/libexec/path_helper ]]; then
    PATH=""
    eval $(/usr/libexec/path_helper -s)
fi

alias vim="nvim"

export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export LESS="-F -g -i -M -R -S -w -X -z-4"
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export NVM_DIR="$HOME/.nvm"

# Go
export PATH=$PATH:$HOME/go/bin

# Roku
# export ROKU_IP=172.21.155.7
# alias roku_console="telnet $ROKU_IP 8085"

# Android
# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/platform-tools
