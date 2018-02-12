export ZSH=~/.oh-my-zsh

ZSH_THEME="powerlevel9k/powerlevel9k"
export TERM="xterm-256color"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv context dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status time)
POWERLEVEL9K_ALWAYS_SHOW_USER="true"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="black"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="yellow"

DEFAULT_USER=$USER

# case-sensitive completion.
CASE_SENSITIVE="true"

plugins=(docker-compose kubectl colored-man-pages web-search)

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/go/bin:/usr/local/go/bin:$PATH"

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

# tested on gpg 2.0.22 (CentOS 7) and 2.1.11 (Ubuntu 16.04.2)
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
if [ $? -ne 0 ]; then
    gpg-agent --daemon > /dev/null 2>&1
fi
if [ -e "${HOME}/.gnupg/S.gpg-agent.ssh" ]; then
    # CentOS 7
    export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
elif [ -e "/run/user/$UID/gnupg/S.gpg-agent.ssh" ]; then
    # Fedora 27
    export SSH_AUTH_SOCK=/run/user/$UID/gnupg/S.gpg-agent.ssh
fi

VENVWRAPPER=~/.local/bin/virtualenvwrapper.sh
if [ -f $VENVWRAPPER ]; then
    source $VENVWRAPPER
fi

# autojump (https://github.com/wting/autojump)
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh

# fzf (https://github.com/junegunn/fzf)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
