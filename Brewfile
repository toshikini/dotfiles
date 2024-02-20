tap "homebrew/bundle"

############################
# Terminal
############################

# シンプルなRust製のターミナル
# 今までiTerm2を使っていたけど、他のターミナルを色々試し中
# Alacrittyを使う前はWrapをしばらく使ってたけど使わない機能が目障りで
# もっとシンプルなターミナルを探していたらAlacrittyを見つけた
# 設定を全てファイルで書けて見た目も機能もシンプルなので気に入ってる
cask "alacritty"

# AlacrittyはシンプルすぎてHotkeyがない
# Ctrl2回押したらターミナルを表示したいのでhammerspoonで実現
cask "hammerspoon"

# Alacrittyはシンプルすぎてタブ機能がない
# そのためマルチプレクサとしてzellijを入れる
# TmuxでもいいけどRust製という理由でzellij
brew "zellij"

# zshのコマンドプロンプトの見た目をよくするために
# 設定なしでデフォルトで使い勝手いいのでstarshipを使ってる
brew "starship"

# zshのプラグインマネージャー
# 色々選択肢はあるけどシンプルに使えるsheldonを入れてる
brew "sheldon"


############################
# Nerd Font For Terminal
############################
tap "homebrew/cask-fonts"

# ターミナルで使うフォントは白源。きれい
cask "font-hackgen"
cask "font-hackgen-nerd"

############################
# Useful Terminal Command
############################
brew "wget"

# Githubの操作はghコマンドでやる
# gitコマンドだとsshの設定が必要だけどghだとOAuthで認証できて簡単に使える
brew "gh"

# Githubのリポジトリ操作コマンド
# ローカルにあるリポジトリの一覧を取得するのに便利
brew "ghq"

# jsonをきれいに表示する
brew "jq"

# テキストファイルの文字コードを変換
brew "nkf"

# あいまい検索
brew "sk"

# rmしたらmacのゴミ箱に移動するようにする
brew "trash"

# TUIのファイルマネージャー
brew "lf"

# topの高機能版
brew "htop"

# コードのステップカウント
brew "tokei"

# catの高機能版
brew "bat"

# lsの高機能版
brew "exa"

# pdfの中身を見るために
# lfのプレビューで使用する
brew "poppler"

# 画像をターミナルで表示するために
# lfのプレビューで使用する
brew "chafa"


############################
# プログラミング言語のバージョン管理ツール asdf
############################

# PythonもNode.jsもRubyもbrewや*envからasdfに移行
# asdf経由でPython, Ruby, Node.js, npm, Poetryを入れる
brew "asdf"


############################
# Python
############################

# Pythonをローカルで開発するときはpoetryで仮想化する方針
# poetryはasdf経由で入れることにした。
# brew "poetry"

# 使うシーンあるけど必要になった時に入れる
# 前の環境で何のために入れたのか記憶があいまい
# brew "pyenv"
# brew "pyenv-virtualenv"
# brew "pipenv"

############################
# Node.js
############################

# voltaでリポジトリ単位でバージョンを切り替えて仮想化できるので
# nodeはasdf経由で入れることにした。
# brew "volta"

############################
# VIM
############################

# vimのプラグインが昔より便利になって統合開発環境ぽく使えるので、
# vscodeからvimにメインのエディタを変更
# mac標準のviではなくvimの最新版を使うためにbrew経由で入れる
brew "vim"

# Escで入力モードを抜ける時に日本語入力から英字入力に戻すためにim-selectを入れる
# hammerspoonで設定したので不要
# tap "daipeihust/tap"
# brew "daipeihust/tap/im-select"


############################
# Docker
############################

# Docker Desktopはcask経由で入れる
# 今はLimaでDocker環境を試しているのでコメントアウト
# cask "docker"

# Docker on Lima
# LimaでDockerを動かす実験中
# Limaの場合は個別にdockerとdocker-composeコマンドを入れる必要あり
brew "lima"
brew "docker"
brew "docker-compose"


############################
# Utility
############################

# パスワードマネージャー
# ブラウザのパスワードマネージャーは使わず全て1Passwordに寄せてる
cask "1password"
cask "1password-cli"

# Spotlightの高機能版
# Alfredでクリップボード履歴やスニペットも使ってる
# Alfredの代替としてRaycastも気になってるけどAlfredの有料版にお金払ってしまった
cask "alfred"

# スリープさせずにずっと起動させておきたい時のために
cask "keepingyouawake"

# 英字キーボードでCmd単体で押した時に日本語キーボードの
# 「英数」「かな」キーのように入力方法を切り替える
# 今どっちの入力だったかわからないというのを解消する
# hammerspoonで設定したので不要
# cask "cmd-eikana"

# スクリーンショットアノテーションツール
cask "shottr"

# Google Driveの同期ツール
cask "google-drive"


############################
# タイル型ウインドウマネージャー yabai
############################

# tap "koekeishiya/formulae"
# brew "yabai"

# yabaiをショートカットで使うために入れる
# brew "skhd"


############################
# Cask Application
############################

# 2段階認証アプリはAuthyを使ってる
# 複数端末で使えてMacからも使えるので便利
cask "authy"

# Chromiumベースのブラウザ
# タブをサイド表示にできるのでWebアプリのタブをピンしても気にならないので気に入ってる
# これを入れてから個別にChrome、Slack、Google Chat、Mailのアプリは使わなくなった
cask "brave-browser"

# ブラウザでfigma開いていると重たくなるのでアプリを入れる
cask "figma"

# Markdownエディタ
# Notion -> Craftと使ってきて今はObsidianをiCloudで同期して使ってる
cask "obsidian"

# テレビ会議のzoom
cask "zoom"


############################
# App Store
############################

# App Storeのアプリをbrew経由でインストール・更新するために
brew "mas"

# ウインド操作を簡単にするために
# 昔から入れてるけど別のアプリで代替できるのではないかと思ってる
# hammerspoonで設定したので不要
# mas "BetterSnapTool", id: 417375580

# Adobe Creative Cloudを入れると重たくなるので
# LightroomはApp Store経由で入れる
mas "Adobe Lightroom", id: 1451544217

# OfficeはApp Store経由で使うものだけ入れる
# Microsoftのサイト経由でダウンローダー使うとOutlookとか色々入ってしまうので
mas "Microsoft Excel", id: 462058435
mas "Microsoft PowerPoint", id: 462062816
mas "Microsoft Word", id: 462054704

# 本はKindle
mas "Kindle", id: 302584613

# LINEもmacからメッセージ書けるようにする
mas "LINE", id: 539883307


############################
# Visual Studio Code
############################
# 前までvscodeを使用してたけど最近はvimに戻ってきたので全てコメントアウト
# cask "visual-studio-code"
# vscode "EditorConfig.EditorConfig"
# vscode "esbenp.prettier-vscode"
# vscode "formulahendry.vscode-mysql"
# vscode "GitHub.copilot"
# vscode "GitHub.copilot-chat"
# vscode "github.vscode-github-actions"
# vscode "GraphQL.vscode-graphql"
# vscode "GraphQL.vscode-graphql-syntax"
# vscode "mechatroner.rainbow-csv"
# vscode "ms-azuretools.vscode-docker"
# vscode "MS-CEINTL.vscode-language-pack-ja"
# vscode "ms-python.black-formatter"
# vscode "ms-python.flake8"
# vscode "ms-python.isort"
# vscode "ms-python.python"
# vscode "ms-python.vscode-pylance"
# vscode "ms-toolsai.jupyter"
# vscode "ms-toolsai.jupyter-keymap"
# vscode "ms-toolsai.jupyter-renderers"
# vscode "ms-toolsai.vscode-jupyter-cell-tags"
# vscode "ms-toolsai.vscode-jupyter-slideshow"
# vscode "ms-vscode-remote.remote-containers"
# vscode "ms-vscode.makefile-tools"
# vscode "NickCernis.github-cli-ui"
# vscode "svelte.svelte-vscode"
