-- ~/.config/nvim/init.lua

-- Leaderキーは他の設定やプラグインが読み込まれる前に設定するのが鉄則です
vim.g.mapleader = " "

-- coreディレクトリ配下の設定ファイルを読み込む
require("core.options")
require("core.keymaps")

-- lazy.nvim (プラグインマネージャー) の自動インストール設定
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lua/plugins/init.lua に書いたプラグインリストを読み込む
require("lazy").setup("plugins")
