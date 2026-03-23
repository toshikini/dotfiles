-- ~/.config/nvim/lua/core/keymaps.lua

local keymap = vim.keymap.set
-- noremap(再帰的なマッピングを防ぐ)と、silent(コマンドラインに実行結果を出さない)をデフォルトにするオプション
local opts = { noremap = true, silent = true }

-- 折り返し時に表示行単位での移動できるようにする
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- 大文字のhjklの動きを変える
keymap("n", "J", "15j", opts)
keymap("n", "K", "15k", opts)
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)

-- ESC連打でハイライト解除
keymap("n", "<Esc><Esc>", ":nohlsearch<CR><Esc>", opts)

-- 入力モード時のカーソル移動
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-l>", "<Right>", opts)

-- 文字の削除、置き換え時yankしないようにする
keymap({ "n", "v" }, "x", '"_x', opts)
keymap({ "n", "v" }, "X", '"_X', opts)
keymap({ "n", "v" }, "s", '"_s', opts)
keymap({ "n", "v" }, "S", '"_S', opts)

-- 【改善】ビジュアルモードでペーストした時に、上書きされたテキストをヤンクしない
-- （元の複雑なexprマッピングを、Neovimで標準的な "_dP というスマートな記述に置き換えました）
keymap("x", "p", '"_dP', opts)

-- 複数画面の移動をスペースで
keymap("n", "<Space>", "<C-w>w", opts)

-- 画面サイズの変更は矢印でも
keymap("n", "<C-w><left>", "<C-w><", opts)
keymap("n", "<C-w><right>", "<C-w>>", opts)
keymap("n", "<C-w><up>", "<C-w>+", opts)
keymap("n", "<C-w><down>", "<C-w>-", opts)

-- ;でコマンドモードに入る
keymap("n", ";", ":", { noremap = true }) -- これだけは文字入力が見えるようにsilentを外します

-- カーソルのあるウインドウを最大化する / 隠す
keymap("n", "<Leader>o", "<C-w>o", opts)
keymap("n", "<Leader>h", ":hide<CR>", opts)

-- ファイル保存:バッファ変更時のみ保存
keymap("n", "<Leader>s", ":<C-u>w<CR>", opts)
