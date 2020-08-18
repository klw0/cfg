#
# Loads prompt themes.
#

# TODO: move this somewhere more generic?  zshenv or zshrc
fpath=(
  ${0:h}/functions
  $fpath
)

# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit

prompt keithy
