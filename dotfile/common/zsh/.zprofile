#
# Executes commands in login shells, before executing zshrc.
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

if [[ -x /usr/libexec/path_helper ]]; then
    PATH=""
    eval $(/usr/libexec/path_helper -s)
fi

path=(
    $HOME/bin
    $path
    $HOME/go/bin
)

host_include=~/.zprofile@$(hostname -s)
if [ -f "${host_include}" ]; then
    . "${host_include}"
fi
unset host_include
