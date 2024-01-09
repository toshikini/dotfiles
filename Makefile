# Brewfileを使ってインストールをする
brew:
	brew bundle cleanup --force
	brew bundle
	brew upgrade
	brew upgrade --cask --greedy
