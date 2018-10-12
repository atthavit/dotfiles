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
stow flake8
...
```
fzf
===

* install [ag](https://github.com/ggreer/the_silver_searcher)

* install fzf

        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        cd ~/.fzf
        ./install --completion --no-key-bindings --no-update-rc


vim
===
* ALE requires **Vim 8**
* More info <https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source>
* compile vim from source

        ./configure --enable-gui --with-features=huge --enable-python3interp --with-x

* `grep X11 src/auto/config.h` should see `#define HAVE_X11 1`

* `make && sudo make install`

* install vim-plug (https://github.com/junegunn/vim-plug)  

        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


* powerline fonts https://github.com/powerline/fonts  
* install plugins in vim

        :PlugInstall

* install flake8, jedi, neovim(required by deoplete)

        python3 -m pip install --user flake8 jedi neovim


tmux
====
* powerline  

        pip install --user powerline-status


zsh
===
* install oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)  

        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

* install powerlevel9k theme (https://github.com/bhilburn/powerlevel9k)  

        git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

* install zsh-autosuggestions

        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

* install autojump (https://github.com/wting/autojump)

        git clone https://github.com/wting/autojump.git
        cd autojump && ./install.py


ctags
=====

    ctags -R --tag-relative=yes -o .git/tags .


gpg
===

CentOS 7 / Fedora 27

        yum install gnupg2 pinentry pinentry-qt4 gnupg2-smime pcsc-lite pcsc-lite-ccid

Ubuntu 16.04/18.04

        apt-get install gnupg2 pcscd scdaemon pinentry-qt


npm
===

    mkdir ~/.npm-global
    npm config set prefix ~/.npm-global
