#!/bin/bash

# macOS出なければ終了
if [ "$(uname)" != "Darwin" ] ; then
  echo 'Not macOS!'
  exit 1
fi

###############################################
# sound
###############################################

# 起動時の起動音の無効化
if ! nvram StartupMute 2>/dev/null | grep -q '%01'; then
  sudo nvram StartupMute=%01
fi

# 警告音の音量をゼロにする
defaults write com.apple.systemsound "AlertVolume" -float 0
# 設定画面のボリュームが変更されないので手動対応必要

# turn off play user interface sound effects
# 該当するコマンドを見つけれず

# 音量を変更するときにフィードバックを再生をオフにする
defaults write NSGlobalDomain com.apple.sound.beep.feedback -bool false

# 設定を即座反映
killall SystemUIServer

###############################################
# Dock
###############################################

# Dockのアイコンサイズを1〜128の範囲で指定
defaults write com.apple.dock tilesize -int 64

# ウィンドウをしまう時のアニメーションをシンプルに
defaults write com.apple.dock mineffect -string scale

# 起動中のアプリのアニメーション無効化
defaults write com.apple.dock launchanim -bool false

# Dockの自動表示/非表示機能を有効化
defaults write com.apple.dock autohide -bool true

# Dock表示速度 最速化
defaults write com.apple.dock autohide-delay -int 0

# Dock表示アニメーション速度 最速化
defaults write com.apple.dock autohide-time-modifier -int 0

killall Dock

###############################################
# Finder
# ###############################################

# 拡張子まで表示する設定
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# 隠しファイルを表示する設定
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Finderウィンドウ下部のパスバーを表示する設定
defaults write com.apple.finder ShowPathbar -bool true


###############################################
# キーボード
###############################################

# 英字入力の時に英字キーを長押ししたときの挙動を変更
# キー長押しで入力文字の連打を有効にする
defaults write -g ApplePressAndHoldEnabled -bool false

# キーリピートの速度（押し続けたときの反復間隔）を高速に設定する
defaults write NSGlobalDomain KeyRepeat -int 3

# キーリピート開始までの待機時間を短く設定する
defaults write NSGlobalDomain InitialKeyRepeat -int 20

# 入力時の自動スペル修正を無効化する
defaults write NSAutomaticSpellingCorrectionEnabled -bool false

# Web入力エリアでの自動スペル修正を無効化する
defaults write WebAutomaticSpellingCorrectionEnabled -bool false

# 自動大文字変換（文頭などの大文字化）を無効化する
defaults write NSAutomaticCapitalizationEnabled -bool false

# ダブルスペースでピリオド変換する機能を無効化する
defaults write NSAutomaticPeriodSubstitutionEnabled -bool false

# 入力時のダッシュへの自動変換を無効化する
defaults write NSAutomaticDashSubstitutionEnabled -bool false

# 入力時のクォート（引用符）の自動変換を無効化する
defaults write NSAutomaticQuoteSubstitutionEnabled -bool false

# 日本語入力のライブ変換を無効化する
defaults write com.apple.inputmethod.Kotoeri 'JIMPrefLiveConversionKey' -bool false




