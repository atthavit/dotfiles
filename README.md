```
cd ~
git clone https://gitlab.com/nocchio/dotfiles.git
cd dotfiles
stow vim
touch ~/.vimrc.local
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


nvim (v0.6.1+)
==============
* install neovim (https://github.com/neovim/neovim)
* install vim-plug (https://github.com/junegunn/vim-plug)  

    ```
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    ```


* powerline fonts https://github.com/powerline/fonts  
* install plugins

    ```
    :PlugInstall
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
