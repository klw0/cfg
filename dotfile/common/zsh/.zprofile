#
# Executes commands in login shells, before executing zshrc.
#

host_include=~/.zprofile@$(hostname -s)
if [ -f "${host_include}" ]; then
    . "${host_include}"
fi
unset host_include
