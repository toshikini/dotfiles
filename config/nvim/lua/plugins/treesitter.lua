return {
  -- 構文解析・色付け (vim-polyglot, rust.vimの一部の代替)
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
  },
}
