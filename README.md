    stow vim
    stow tmux
    stow powerline
    stow zsh

vim
=====
* install vim-plug (https://github.com/junegunn/vim-plug)  

        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


* powerline fonts https://github.com/powerline/fonts  
* install plugins in vim

        :PlugInstall

tmux
=====
*  powerline  

        pip install --user powerline-status


zsh
=====
* install oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)  

        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

* install powerlevel9k theme (https://github.com/bhilburn/powerlevel9k)  

        git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

