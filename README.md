## aicro-nishihata/dotfiles

### Setup macOS

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```


```
git clone https://github.com/aicro-nishihata/dotfiles.git
ln -s dotfiles/zshrc ~/.zshrc
```

```
cd dotfiles
brew bundle
```

```
ln -s dotfiles/vimrc .vimrc
```

```
ln -s dotfiles/hammerspoon ~/.hammerspoon
```


```
ln -s dotfiles/gitconfig ~/.gitconfig
```

