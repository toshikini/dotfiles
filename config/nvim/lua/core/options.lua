-- ~/.config/nvim/lua/core/options.lua

local opt = vim.opt

-- エンコーディング
opt.fileencoding = "utf-8"
opt.fileencodings = { "utf-8", "sjis", "euc-jp", "iso-2022-jp" }

-- 基本設定
opt.backup = false
opt.swapfile = false
opt.scrolloff = 5
opt.mouse = "a"

-- 表示
opt.ruler = true
opt.number = true
opt.cursorline = true
opt.virtualedit = "onemore"
opt.smartindent = true
opt.visualbell = true
opt.showmatch = true
opt.wildmode = "list:longest"

-- Tab
opt.list = true
opt.listchars = { eol = "↲", tab = "»-", trail = "_" }
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

-- 検索
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true
opt.hlsearch = true

-- Undoの永続化（Neovimのデフォルト機能を使用。自動的に ~/.local/state/nvim/undo に保存されます）
opt.undofile = true

-- 入力の設定
opt.autoindent = true
opt.clipboard:append("unnamedplus") -- Neovim推奨：OSのクリップボードと完全に同期
opt.formatoptions:append("mM")
