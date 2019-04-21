#
# Sourced in interactive shells.
#

# Load zsh configuration files.
for file (~/.zsh/*.zsh(N)); do
    source $file
done

# nvm
if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
    source "$HOME/.nvm/nvm.sh"
fi

# rbenv
if [[ -x $(command -v rbenv) ]]; then
    eval "$(rbenv init -)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
