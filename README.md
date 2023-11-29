## aicro-nishihata/dotfiles

### Setup macOS

**Install Homebrew**
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Git Clone**
```
git clone https://github.com/aicro-nishihata/dotfiles.git
```

**Link .zshrc**
```
ln -s dotfiles/zshrc ~/.zshrc
source ~/.zshrc
```

**brew**
```
make brew
```

**Link config**
```
ln -s dotfiles/vimrc .vimrc
ln -s dotfiles/hammerspoon ~/.hammerspoon
ln -s dotfiles/gitconfig ~/.gitconfig
ln -s dotfiles/config ~/.config
```

