if [[ "$OSTYPE" == "darwin"* ]]; then
    macos=true
fi

export ZSH=~/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv context dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(kubecontext command_execution_time status time)
POWERLEVEL9K_ALWAYS_SHOW_USER="true"

DARK=237
LIGHT0=230
LIGHT1=180
# LIGHT1=222
# LIGHT1=7
RED=167
GREEN=77
YELLOW=214
BLUE=24

POWERLEVEL9K_VIRTUALENV_BACKGROUND=$BLUE
POWERLEVEL9K_VIRTUALENV_FOREGROUND=$LIGHT0

POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND=$LIGHT0
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=$DARK
POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND
POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND
POWERLEVEL9K_CONTEXT_REMOTE_SUDO_BACKGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND
POWERLEVEL9K_CONTEXT_REMOTE_SUDO_FOREGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND
POWERLEVEL9K_CONTEXT_SUDO_BACKGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND
POWERLEVEL9K_CONTEXT_SUDO_FOREGROUND=$POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND

POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=$LIGHT1
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=$DARK
POWERLEVEL9K_DIR_ETC_BACKGROUND=$POWERLEVEL9K_DIR_DEFAULT_BACKGROUND
POWERLEVEL9K_DIR_ETC_FOREGROUND=$POWERLEVEL9K_DIR_DEFAULT_FOREGROUND
POWERLEVEL9K_DIR_HOME_BACKGROUND=$POWERLEVEL9K_DIR_DEFAULT_BACKGROUND
POWERLEVEL9K_DIR_HOME_FOREGROUND=$POWERLEVEL9K_DIR_DEFAULT_FOREGROUND
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=$POWERLEVEL9K_DIR_DEFAULT_BACKGROUND
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=$POWERLEVEL9K_DIR_DEFAULT_FOREGROUND

POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=$RED
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND=$LIGHT0

POWERLEVEL9K_VCS_CLEAN_BACKGROUND=$DARK
POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$GREEN
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=$POWERLEVEL9K_VCS_CLEAN_BACKGROUND
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$YELLOW
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=$POWERLEVEL9K_VCS_CLEAN_BACKGROUND
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$GREEN

POWERLEVEL9K_KUBECONTEXT_BACKGROUND=$BLUE
POWERLEVEL9K_KUBECONTEXT_FOREGROUND=$LIGHT0

POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=$LIGHT1
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$DARK

POWERLEVEL9K_STATUS_ERROR_BACKGROUND=$RED
POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$LIGHT0
POWERLEVEL9K_STATUS_OK_BACKGROUND=$DARK
POWERLEVEL9K_STATUS_OK_FOREGROUND=$GREEN

POWERLEVEL9K_TIME_BACKGROUND=$LIGHT0
POWERLEVEL9K_TIME_FOREGROUND=$DARK

# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
# POWERLEVEL9K_MODE='compatible'

DEFAULT_USER=$USER

# case-sensitive completion.
CASE_SENSITIVE="true"

plugins=(docker-compose colored-man-pages web-search zsh-autosuggestions)

export GOPATH="$HOME/go"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"
export PATH="$HOME/.mix/escripts:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/usr/local/flutter/bin:$PATH"

if [ "$macos" = true ]; then
    export PATH="$HOME/Library/Python/3.8/bin:$PATH"
    export PATH="$HOME/Library/Python/3.9/bin:$PATH"
fi

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR='nvim'
export VISUAL="$EDITOR"

export QUOTING_STYLE='literal'

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[4~"   end-of-line
bindkey '^R' history-incremental-search-backward

setopt No_histverify
unsetopt autocd

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# tested on gpg 2.0.22 (CentOS 7), 2.1.11 (Ubuntu 16.04.2) and 2.2.4 (Ubuntu 18.04.1)
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

VIRTUALENVWRAPPER_PYTHON=python3
if [ "$macos" = true ]; then
    VENVWRAPPER=~/Library/Python/3.9/bin/virtualenvwrapper.sh
else
    VENVWRAPPER=~/.local/bin/virtualenvwrapper.sh
fi
if [ -f $VENVWRAPPER ]; then
    source $VENVWRAPPER
fi

# autojump (https://github.com/wting/autojump)
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh

# fzf (https://github.com/junegunn/fzf)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules --ignore deps --ignore _build -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# terraform
export TF_CLI_ARGS_plan="-parallelism=100"
export TF_CLI_ARGS_apply="-parallelism=100"

. $HOME/.asdf/asdf.sh
. "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(atuin gen-completions --shell zsh)"
