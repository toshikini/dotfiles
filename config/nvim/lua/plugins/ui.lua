return {
  -- ステータスライン (lightlineの代替)
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = { theme = "wombat" },
        tabline = {
          lualine_a = { "buffers" },
        },
      })
    end,
  },
  -- スムーズスクロール (comfortable-motionの代替)
  {
    "karb94/neoscroll.nvim",
    config = function() require("neoscroll").setup({}) end,
  },
  -- ブックマーク機能
  {
    "MattesGroeger/vim-bookmarks",
    init = function()
      vim.g.bookmark_auto_close = 1
    end,
  },
  -- インデントガイド (vim-indent-guidesのモダンな代替)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },
}
