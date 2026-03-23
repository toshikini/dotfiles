return {
  {
    "xiyaowong/transparent.nvim",
    event = "VeryLazy",
    config = function()
      require("transparent").setup()
      vim.cmd("TransparentEnable")
    end,
  },
}
