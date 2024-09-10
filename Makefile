# Brewfileを使ってインストールをする
brew:
	export HOMEBREW_NO_ENV_HINTS=1 && \
	brew bundle cleanup --force && \
	brew bundle && \
	brew upgrade && \
	brew upgrade --cask --greedy

# 設定ファイルをシンボリックリンクでつなぐ
link:
	ln -s dotfiles/zshrc .zshrc
	ln -s dotfiles/vimrc .vimrc
	ln -s dotfiles/hammerspoon ~/.hammerspoon
	ln -s dotfiles/gitconfig ~/.gitconfig
	ln -s dotfiles/config ~/.config
