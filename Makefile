# Brewfileを使ってインストールをする
brew:
	brew bundle cleanup --force
	brew upgrade
	brew upgrade --cask --greedy
	brew bundle


