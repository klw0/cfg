#
# Defines environment variables.
#

# Set up the path
if [[ -x /usr/libexec/path_helper ]]; then
    PATH=""
    eval $(/usr/libexec/path_helper -s)
fi

alias vim="nvim"
alias xclip="xclip -selection clipboard"

export LC_ALL=en_US.UTF-8
export EDITOR="${aliases[vim]}"
export VISUAL="${aliases[vim]}"
export PAGER="less"
export LESS="-g -i -M -R -S -w -X -z-4"
export FZF_DEFAULT_COMMAND="rg --files"
export NVM_DIR="$HOME/.nvm"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"
export GPG_TTY=$(tty)

# Go
export PATH=$PATH:$HOME/go/bin

# Roku
# export ROKU_IP=172.21.155.7
# alias roku_console="telnet $ROKU_IP 8085"

# Android
# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/platform-tools
