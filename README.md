```
cd ~
git clone https://gitlab.com/nocchio/dotfiles.git
cd dotfiles
stow vim
stow tmux
stow aliases
mkdir ~/.config
mkdir ~/.gnupg && stow gpg
stow powerline
stow yapf
...
```

vim-pc
======
* ALE requires **Vim 8**
* compile vim with options:

        ./configure --enable-gui=yes --with-features=huge --enable-python3interp

* install vim-plug (https://github.com/junegunn/vim-plug)  

        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


* powerline fonts https://github.com/powerline/fonts  
* install plugins in vim

        :PlugInstall

* install flake8 (syntax checking for python)

        pip install flake8


tmux-pc
=======
* install tmux 2.3
* powerline  

        pip install --user powerline-status


zsh
===
* install oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)  

        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

* install powerlevel9k theme (https://github.com/bhilburn/powerlevel9k)  

        git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

* install autojump (https://github.com/wting/autojump)

        git clone https://github.com/wting/autojump.git
        cd autojump && ./install.py


ctags
=====

    ctags -R --tag-relative=yes -o .git/tags .


gpg
===

CentOS 7

        yum install gnupg2 pinentry pinentry-qt4 gnupg2-smime pcsc-lite pcsc-lite-ccid

Ubuntu 16.04

        apt-get install gnupg2 pcscd scdaemon pinentry-qt
