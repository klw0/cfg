#
# Executes commands in interactive shells.
#

alias cp="cp -i"
alias dirs="dirs -v"
alias find="noglob find"
alias history="noglob history"
alias ls="ls -F"
alias mv="mv -i"
alias rm="rm -i"
alias rsync="noglob rsync"
alias scp="noglob scp"
alias sftp="noglob sftp"
alias vim="nvim"
alias xclip="xclip -selection clipboard"

# Add `help` alias for help with builtins.
unalias run-help
autoload -Uz run-help
alias help="run-help"

if [[ "${OSTYPE}" == "openbsd"* ]]; then
    alias man="man -m ~/share/man"
elif [[ "${OSTYPE}" == "freebsd"* ]]; then
    alias man="man -S 0p:1:1p:8:2:3:3p:n:4:5:6:7:9:l"
fi

export PREFIX=~
export LC_ALL=en_US.UTF-8
export EDITOR="${aliases[vim]}"
export VISUAL="${aliases[vim]}"
export PAGER="less"
export LESS="-g -i -M -R -S -w -X -z-4 -j4 -c"
export GPG_TTY=$(tty)
export FZF_DEFAULT_COMMAND="rg --files"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"

export LESS_TERMCAP_mb=$"\e[01;31m"      # Begins blinking.
export LESS_TERMCAP_md=$"\e[01;31m"      # Begins bold.
export LESS_TERMCAP_me=$"\e[0m"          # Ends mode.
export LESS_TERMCAP_se=$"\e[0m"          # Ends standout-mode.
export LESS_TERMCAP_so=$"\e[00;47;30m"   # Begins standout-mode.
export LESS_TERMCAP_ue=$"\e[0m"          # Ends underline.
export LESS_TERMCAP_us=$"\e[01;32m"      # Begins underline.

typeset -gU path
path=(
    $HOME/bin
    $path
    $HOME/go/bin
)

hash -d src=~/src
hash -d cfg=~/src/klw0/cfg

function t() {
    cd $(mktemp -d -t "${1:-tmp}".XXXXXXXXXX)
}

# -----------------------------------------------------------------------------
# zsh: General
# -----------------------------------------------------------------------------

setopt AUTO_PUSHD
setopt AUTO_RESUME
setopt CDABLE_VARS
setopt COMBINING_CHARS
setopt CORRECT
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS
setopt LONG_LIST_JOBS
setopt MULTIOS
setopt NOTIFY
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME
setopt RC_QUOTES
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

setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt HIST_BEEP
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY

source "${ZDOTDIR:-$HOME/.zsh}/vendor/zsh-history-substring-search/zsh-history-substring-search.zsh" || return 1

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
unsetopt MENU_COMPLETE

autoload -Uz compinit
compinit -i

zstyle ":completion:*" menu select
zstyle ":completion:*" group-name ""
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

zstyle ":completion:*:default" list-prompt "%S%M matches%s"
zstyle ":completion:*" format " %F{yellow}── %d ──%f"
zstyle ":completion:*:corrections" format " %F{green}── %d (errors: %e) ──%f"
zstyle ":completion:*:descriptions" format " %F{yellow}── %d ──%f"
zstyle ":completion:*:messages" format " %F{purple}── %d ──%f"
zstyle ":completion:*:warnings" format " %F{red}── no matches found ──%f"

# -----------------------------------------------------------------------------
# zsh: Prompt
# -----------------------------------------------------------------------------

typeset -gU fpath
fpath=("${ZDOTDIR:-$HOME/.zsh}/functions" $fpath)

autoload -Uz promptinit
promptinit

prompt keithy

# -----------------------------------------------------------------------------
# zsh: Line Editing
# -----------------------------------------------------------------------------

KEYTIMEOUT=10

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd "^v" edit-command-line

zmodload zsh/terminfo
bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
# Use vim-style backspace behavior, not the default vi-style which disallows
# backspacing over the start of insert.
bindkey -M viins "^?" backward-delete-char

autoload -Uz add-zle-hook-widget

add-zle-hook-widget keymap-select reset-prompt
# Give the mode indicator a chance to reset before committing the command to the
# buffer history. This isn't strictly necessary, but is a nice UX improvement.
add-zle-hook-widget line-finish reset-prompt
