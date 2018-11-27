#
# Sourced in interactive shells.
#

# Load zsh configuration files.
for file (~/.zsh/*.zsh(N)); do
    source $file
done

# rbenv
if [[ -x $(command -v rbenv) ]]; then
    eval "$(rbenv init -)"
fi
