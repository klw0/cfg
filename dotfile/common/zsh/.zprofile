#
# Executes commands in login shells, before executing zshrc.
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

host_include=~/.zprofile@$(hostname -s)
if [ -f "${host_include}" ]; then
    . "${host_include}"
fi
unset host_include
