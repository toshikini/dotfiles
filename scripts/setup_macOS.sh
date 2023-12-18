#!/bin/bash

# macOS出なければ終了
if [ "$(uname)" != "Darwin" ] ; then
  echo 'Not macOS!'
  exit 1
fi

###############################################
# キーボード
###############################################

# 英字入力の時に英字キーを長押ししたときの挙動を変更
# キー長押しで入力文字の連打を有効にする
defaults write -g ApplePressAndHoldEnabled -bool false
