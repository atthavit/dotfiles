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

    ```bash
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    cd ~/.fzf
    ./install --completion --no-key-bindings --no-update-rc
    ```


nvim
====
* install neovim (https://github.com/neovim/neovim)
* install vim-plug (https://github.com/junegunn/vim-plug)  

    ```
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    ```


* install pynvim (https://github.com/neovim/pynvim)
* powerline fonts https://github.com/powerline/fonts  
* install plugins

    ```
    :PlugInstall
    ```

* install flake8, jedi, neovim(required by deoplete)

    ```
    python3 -m pip install --user flake8 jedi neovim
    ```

* install xclip

    ```
    apt install xclip
    ```


tmux
====
* powerline  

    ```
    pip install --user powerline-status
    ```


zsh
===
* install oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)  

    ```
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    ```

* install powerlevel10k theme (https://github.com/romkatv/powerlevel10k)  

    ```
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
    ```

* install zsh-autosuggestions

    ```
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ```

* install autojump (https://github.com/wting/autojump)

    ```
    git clone https://github.com/wting/autojump.git
    cd autojump && ./install.py
    ```


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
