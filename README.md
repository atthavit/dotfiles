```
cd ~
git clone https://gitlab.com/nocchio/dotfiles.git
cd dotfiles
stow vim
stow tmux
stow aliases
...
```

vim-pc
=====
* install vim-plug (https://github.com/junegunn/vim-plug)  

        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


* powerline fonts https://github.com/powerline/fonts  
* install plugins in vim

        :PlugInstall

* install flake8 (syntax checking for python)

        pip install flake8


tmux-pc
=====
* install tmux 2.2
* powerline  

        pip install --user powerline-status


zsh
=====
* install oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)  

        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

* install powerlevel9k theme (https://github.com/bhilburn/powerlevel9k)  

        git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k


ctags
=====

    ctags -R --tag-relative=yes -o .git/tags .


