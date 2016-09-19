vim
=====
* install vim-plug (https://github.com/junegunn/vim-plug)
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
* powerline fonts https://github.com/powerline/fonts  

* create symlink to homedir  

* run :PlugInstall

tmux
=====
* install tmux (https://github.com/tmux/tmux)  
* create symlink to homedir  
for powerline  
```
pip install powerline-status
```
* may need to change powerline path in .tmux.conf  

* install tpm (Tmux Plugin Manager) (https://github.com/tmux-plugins/tpm)  
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

* ctrl+b I to install plugins  

zsh
=====
* install zsh
* install oh my zsh (https://github.com/robbyrussell/oh-my-zsh)
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
* install powerlevel9k theme (https://github.com/bhilburn/powerlevel9k)
```
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```
