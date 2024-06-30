# aliases.sh

## install

### using only aliases

#### zsh
```
wget https://raw.githubusercontent.com/gabriellopesmarques/.aliases/main/aliases.sh -O $HOME/.aliases.sh
echo "source ~/.aliases.sh" >> ~/.zshrc
```

#### bash
```
wget https://raw.githubusercontent.com/gabriellopesmarques/.aliases/main/aliases.sh -O $HOME/.aliases.sh
echo "source ~/.aliases.sh" >> ~/.bashrc
```

### env

clone the repository
```
git clone <repo>

cd <repo>
```

check avaliable installers scripts
```
./install.sh --help
```

## load files sequence
```
$HOME/.zshrc:
    - ~/.aliases/aliases.sh
        - ~/.aliases/env.sh
    - ~/.aliases/oh-my-zsh/config
        - $ZSH/oh-my-zsh.sh
    - ~/.aliases/aliases.utils.sh
```
