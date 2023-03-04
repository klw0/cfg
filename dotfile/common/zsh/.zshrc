bindkey -v

alias cd="cd > /dev/null"
alias cp="cp -i"
alias dirs="dirs -v"
alias find="noglob find"
alias ls="ls -F"
alias mv="mv -i"
alias rm="rm -i"
alias rsync="noglob rsync"
alias scp="noglob scp"
alias vim="nvim"
alias wiki="cd ~/wiki && vim +VimwikiIndex"
alias xclip="xclip -selection clipboard"

# Add `help` alias for help with builtins.
unalias run-help
autoload -Uz run-help
alias help="run-help"

export PREFIX=~
export LC_ALL=en_US.UTF-8
export EDITOR=$(whence vim)
export VISUAL="${EDITOR}"
export PAGER="less"
export LESS="-g -i -M -R -S -w -X -z-4 -j10 -c"
export GPG_TTY=$(tty)
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"
export GIT_MYREMOTE_ADDR="git@git.ksrv.home.arpa"

case $(uname | tr "[A-Z]" "[a-z]") in
    openbsd)
        alias man="man -m ~/share/man"
        ;;
    darwin)
        export MANWIDTH=78
        eval $(/opt/homebrew/bin/brew shellenv)
        export SSH_AUTH_SOCK=~/.ssh/agent.brew
        ;;
esac

typeset -U path
path=(
    $HOME/bin
    $path
    $HOME/go/bin
)

typeset -U cdpath
cdpath=(
    .
    $HOME/src
    $HOME/src/klw0
)

function t() {
    cd $(mktemp -d -t "${1:-tmp}".XXXXXXXXXX)
}

# -----------------------------------------------------------------------------
# zsh: General
# -----------------------------------------------------------------------------

setopt AUTO_PUSHD
setopt COMBINING_CHARS
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS
setopt LONG_LIST_JOBS
setopt NOTIFY
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME
unsetopt BG_NICE
unsetopt CASE_GLOB
unsetopt CHECK_JOBS
unsetopt CLOBBER
unsetopt FLOW_CONTROL
unsetopt HUP

# -----------------------------------------------------------------------------
# zsh: History
# -----------------------------------------------------------------------------

HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY

source "${ZDOTDIR:-$HOME/.zsh}/vendor/zsh-history-substring-search/zsh-history-substring-search.zsh" || return 1

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=cyan,bold"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=yellow,bold"

bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

# -----------------------------------------------------------------------------
# zsh: Completion
# -----------------------------------------------------------------------------

setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt AUTO_MENU
setopt AUTO_PARAM_SLASH
setopt COMPLETE_IN_WORD
setopt EXTENDED_GLOB
setopt LIST_PACKED
setopt LIST_ROWS_FIRST
unsetopt MENU_COMPLETE

autoload -Uz compinit
compinit -i

zstyle ":completion:*" menu select
zstyle ":completion:*" group-name ""
zstyle ":completion:*" show-ambiguity true
zstyle ":completion:*" special-dirs true
zstyle ":completion:*" squeeze-slashes true
zstyle ":completion:*" verbose yes
zstyle ":completion:*:functions" ignored-patterns "(_*|pre(cmd|exec))"
zstyle ":completion:*:manuals" separate-sections true
zstyle ":completion:*:options" auto-description "%d"
zstyle ":completion::complete:*" cache-path "${ZDOTDIR:-$HOME}/.zcompcache"
zstyle ":completion::complete:*" use-cache on
# Case-insensitive (all), partial-word, and then substring completion.
zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*"
zstyle ":completion:*" completer _complete _match _approximate
zstyle ":completion:*:match:*" original only
zstyle ":completion:*" users ""
zstyle ":completion:*:cd:*" tag-order "! users path-directories"
zstyle ":completion:*:-tilde-:*" tag-order "! users"

zstyle ":completion:*:default" list-prompt "%S%M matches%s"
zstyle ":completion:*" format "%F{cyan}# %d%f"
zstyle ":completion:*:warnings" format ""

# -----------------------------------------------------------------------------
# zsh: Prompt
# -----------------------------------------------------------------------------

setopt PROMPT_CR
setopt PROMPT_SP
setopt PROMPT_PERCENT
setopt PROMPT_SUBST

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
add-zsh-hook precmd vcs_info

zstyle ":vcs_info:*" enable git cvs
zstyle ":vcs_info:*:*" disable-patterns "*.git*"
zstyle ":vcs_info:*:*" actionformats "%s:%b %u%c (%a)"
zstyle ":vcs_info:*:*" formats "%s:%b %u%c"

PS1="${SSH_TTY:+'%m:'}%~ %(!.#.$) "
RPS1='%(?.. [%?])${vcs_info_msg_0_:+ ${vcs_info_msg_0_}}'

# -----------------------------------------------------------------------------
# zsh: Line Editing
# -----------------------------------------------------------------------------

KEYTIMEOUT=10

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd "^v" edit-command-line
bindkey -M vicmd "#" vi-pound-insert

zmodload zsh/terminfo
bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
# Use vim-style backspace behavior, not the default vi-style which disallows
# backspacing over the start of insert.
bindkey -M viins "^?" backward-delete-char

zmodload zsh/complist
bindkey -M menuselect '^e' send-break


[ -f ~/.zshrc.local ] && source ~/.zshrc.local
