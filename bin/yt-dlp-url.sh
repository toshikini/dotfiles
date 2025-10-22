#!/bin/bash

# === 引数チェック ===
if [[ $# -ne 1 ]]; then
  echo "使い方: $0 URLリストファイル"
  exit 1
fi

URL_FILE="$1"
# FORMAT="bestvideo+bestaudio/best"  # ダウンロードフォーマット

# === URLファイルの存在確認 ===
if [[ ! -f "$URL_FILE" ]]; then
  echo "エラー: $URL_FILE が見つかりません。"
  exit 1
fi

# === ダウンロード処理 ===
while IFS= read -r url; do
  # 空行やコメント行(#で始まる行)はスキップ
  if [[ -z "$url" || "$url" =~ ^# ]]; then
    continue
  fi

  echo "ダウンロード開始: $url"
  # yt-dlp -f "$FORMAT" "$url"
  yt-dlp "$url"
done < "$URL_FILE"

echo "=== すべてのダウンロードが完了しました ==="

