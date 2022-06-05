# vimrc

- install vim
- install [vim-plug](https://github.com/junegunn/vim-plug)
- install [nvm](https://github.com/nvm-sh/nvm) nodejs is a coc.nvim dependency :/
- install nodejs (nvm install --lts)


load vim configs from aliases repository
```bash
echo "source ~/.aliases/vimrc" >> ~/.vimrc
```

- Run `PlugInstall` on vim to install plugins via vim-plug
- Run `CocInstall coc-phpls` to install php support
- check [coc.nvim extension docs](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions) to other languages
- copy to clipboard ```<Leader>y``` (xclip is required [sudo apt-get install xclip])

have fun!

