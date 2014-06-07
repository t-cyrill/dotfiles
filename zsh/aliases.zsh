#!/bin/zsh

alias rm='rm -i'
alias cp='cp -i -p'
alias mv='mv -i'

alias ls='ls --color'
alias l="ls --show-control-chars"
alias la='ls -A'
alias ll='ls -al'
alias lll="ll -t"

alias du="du -h"
alias df="df -h"

type colordiff >/dev/null && alias diff="colordiff -u"
type "vim" > /dev/null && export EDITOR="vim"

alias lv="lv -c"
alias wis="whatisthis"
