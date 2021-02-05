#
# Defines general aliases and functions.
#
# Authors:
#   Robby Russell <robby@planetargon.com>
#   Suraj N. Kurapati <sunaku@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Correct commands.
setopt CORRECT

#
# Aliases
#

# Disable correction.
alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias grep='nocorrect grep'
alias ln='nocorrect ln'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias rm='nocorrect rm'

# Disable globbing.
alias find='noglob find'
alias history='noglob history'
alias rsync='noglob rsync'
alias scp='noglob scp'
alias sftp='noglob sftp'

# Define general aliases.
alias cp="${aliases[cp]:-cp} -i"
alias diffu="diff --unified"
alias ln="${aliases[ln]:-ln} -i"
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias mv="${aliases[mv]:-mv} -i"
alias rm="${aliases[rm]:-rm} -i"
alias type='type -a'
alias df='df -kh'
alias du='du -kh'


# ls
# Define colors for BSD ls.
export LSCOLORS='exfxcxdxbxGxDxabagacad'

# # Define colors for the completion system.
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

color_flag=""
if [[ "${OSTYPE}" == "linux"* ]]; then
    color_flag="--color"
elif [[ "${OSTYPE}" == "darwin"* || "${OSTYPE}" == *"bsd"* ]]; then
    color_flag="-G"
fi

alias ls="${aliases[ls]:-ls} ${color_flag}"

function t {
    cd $(TMPDIR=~/tmp mktemp -d -t "${1:-tmp}")
}

# # Finds files and executes a command on them.
# function find-exec {
#   find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
# }

