# lfのプレビューで必要なツールをインストール

# 使用するpythonとpipがasdf経由でインストールされているか確認
# HOMEに.tool-versionというファイルがあるか確認
# なければこのプログラムは終了
if [ ! -e "$HOME/.tool-versions" ]; then
  echo "asdf経由でpythonをインストールしてください"
  exit 1
fi

# pythonのバージョンを取得
python_version=$(awk '/python/ {print $2}' ~/.tool-versions)

# pythonがglobalに設定されているか確認
# 設定されていなければこのプログラムは終了
if [ -z "$python_version" ]; then
  echo "asdfでpythonをglobalに設定してください"
  exit 1
fi

# asdfを通じてインストールされたpythonのpipを使用
pip_cmd="$HOME/.asdf/installs/python/$python_version/bin/pip"

# エクセルをcsvにしてプレビュー
$pip_cmd install xlsx2csv

# pdfをテキストにしてプレビュー
$pip_cmd install pdftotext

