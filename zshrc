#################################
# 環境変数
#################################

# volta
export VOLTA_HOME="$HOME/.volta"

# voltaでpnpmを使う。pnpmは実験的機能なのでこの設定が必要
export VOLTA_FEATURE_PNPM=1


#################################
# PATH
#################################

export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="/usr/local/bin:$PATH"


#################################
# 設定読み込み
#################################

# brewで入れたコマンドのパスを通す
eval $(/opt/homebrew/bin/brew shellenv)

# zshプラグインマネージャーのsheldonを有効にする
eval "$(sheldon source)"

# zshのプロンプトをかっこよくする
eval "$(starship init zsh)"


# pyenvとvirtualenvを有効にする
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"


#################################
# history
#################################

# ヒストリを保存するファイル
HISTFILE=~/.zsh_history

# ヒストリの保存件数
HISTSIZE=20000

# メモリ上に置いておくヒストリ検索対象の件数
SAVEHIST=20000

# すでに存在するヒストリファイルにヒストリを追記
setopt append_history

# ヒストリファイルを複数のzshで共有
setopt share_history

# history検索のキーバインド
bindkey -e  # ^P, ^N のキーをそれぞれのヒストリ検索に割り当て
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# 検索後のカーソルの単語単位での移動のキーバインド
bindkey '^B' backward-word
bindkey '^F' forward-word

#################################
# 入力補完
#################################

# completion
autoload -Uz compinit
compinit

# 大文字小文字無視
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# 大文字のときは小文字を無視
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

# 大文字見つからなければ小文字
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

# みつからなければ文字種無視
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# 通常補完 -> （小文字 -> 大文字） -> （小文字 -> 大文字 + 大文字 -> 小文字）.
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'


#################################
# alias
#################################

# brew install trashを入れてターミナルからrmをしたら
# macOSのゴミ箱に入るようにする
# 下記を参考にした
# https://qiita.com/TomokiYamashit3/items/d0e0fbbc736400e0aa39
if type trash > /dev/null 2>&1; then
    alias rm='trash -F'
fi

# lsコマンドのエイリアス
case "${OSTYPE}" in
darwin*)
  alias ls="ls -G"
  alias ll="ls -lG"
  alias la="ls -laG"
  ;;
linux*)
  alias l='ls -CF'
  alias la='ls -A'
  alias ll='ls -l'
  alias ls='ls -h --color=always'
  ;;
esac


#################################
# コマンド定義
#################################

# projectコマンド
# ローカルリポジトリの一覧を表示して選択をしたリポジトリパスに移動をする
prject () {
  local prject_path=$(ghq list -p | sk --layout reverse --query "$LBUFFER")
  if [ -z "$prject_path" ]; then
    return
  fi
  cd $prject_path
}

