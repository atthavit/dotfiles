export ZSH=~/.oh-my-zsh

ZSH_THEME="powerlevel9k/powerlevel9k"
export TERM="xterm-256color"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)

DEFAULT_USER=$USER

# case-sensitive completion.
CASE_SENSITIVE="true"

plugins=(git gpg-agent)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
#
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR='vim'
export VISUAL="$EDITOR"

export QUOTING_STYLE='literal'

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[4~"   end-of-line
bindkey '^R' history-incremental-search-backward

[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

setopt No_histverify

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

export PATH=~/.npm-global/bin:$PATH

VENVWRAPPER=~/.local/bin/virtualenvwrapper.sh
if [ -f $VENVWRAPPER ]; then
    source $VENVWRAPPER
fi

# autojump (https://github.com/wting/autojump)
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
