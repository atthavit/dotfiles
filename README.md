```
cd ~
git clone https://github.com/atthavit/dotfiles.git
cd dotfiles
mkdir ~/.config
stow aliases
stow nvim
stow zsh
...
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
