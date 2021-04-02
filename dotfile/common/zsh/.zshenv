#
# Defines environment variables.
#

alias vim="nvim"
alias xclip="xclip -selection clipboard"

export LC_ALL=en_US.UTF-8
export EDITOR="${aliases[vim]}"
export VISUAL="${aliases[vim]}"
export PAGER="less"
export LESS="-g -i -M -R -S -w -X -z-4 -j4 -c"
export FZF_DEFAULT_COMMAND="rg --files"
export NVM_DIR="$HOME/.nvm"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"
export GPG_TTY=$(tty)
# TODO(klw0): Make this portable.
export MANSECT="0p:1:1p:8:2:3:3p:n:4:5:6:7:9:l"

# Roku
# export ROKU_IP=172.21.155.7
# alias roku_console="telnet $ROKU_IP 8085"

# Android
# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/platform-tools
