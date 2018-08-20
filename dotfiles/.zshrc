#
# Sourced in interactive shells.
#

# Load zsh configuration files.
for file (~/.zsh/*.zsh(N)); do
    source $file
done

# rbenv
eval "$(rbenv init -)"
