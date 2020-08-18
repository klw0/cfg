#
# Sourced in interactive shells.
#

# Load zsh configuration files.
for file (~/.zsh/*.zsh(N)); do
    source $file
done

# nvm
if [[ -s "${NVM_DIR}/nvm.sh" ]]; then
    source "${NVM_DIR}/nvm.sh"
fi

# rbenv
if [[ -x $(command -v rbenv) ]]; then
    eval "$(rbenv init -)"
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
