# Set up the prompt
autoload -Uz promptinit
promptinit
prompt walters

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v
bindkey '^[[Z' reverse-menu-complete

HISTSIZE=100000
SAVEHIST=100000

DOTFILES="${HOME}/dotfiles"
ZSH_ROOT="${DOTFILES}/zsh"
HISTFILE="${ZSH_ROOT}/history/.zsh_history"

# Use modern completion system
autoload -Uz compinit
compinit -d "${ZSH_ROOT}/.zcompdump"

setopt auto_pushd pushdsilent
setopt list_packed
unsetopt correctall

export LANG="en_US.UTF-8"
export PATH="$HOME/usr/local/bin:$PATH"
export TERM="xterm-256color"

[ -f "/etc/profile" ] && source /etc/profile
[ -f "${ZSH_ROOT}/zshrc_`uname`" ] && source ${ZSH_ROOT}/zshrc_`uname`

FILES="`\ls ${ZSH_ROOT}/*.zsh`"
echo $FILES | while read -r file; do
  [ -f "$file" ] && source "$file"
done

[ ${STY} ] || screen -rx || screen -D -RR

# command_stack
show_buffer_stack() {
    POSTDISPLAY="
stack: $LBUFFER"
    zle push-line-or-edit
}
zle -N show_buffer_stack
setopt noflowcontrol
bindkey '^Q' show_buffer_stack

whatisthis () {
    if [ -f "${HOME}/.whatisthis" ]; then; cat "${HOME}/.whatisthis"
    else; echo "No description file"
    fi
}

preexec () {
  if [[ $TERMCAP =~ screen ]]; then; lastcmd=(${(s: :)${1}}) && echo -ne "\ek$lastcmd[1]\e\\"
  fi
}

precmd() {
  if [[ $TERMCAP =~ screen ]]; then; name=`basename $SHELL` && echo -ne "\ek$name\e\\"
  fi
}
