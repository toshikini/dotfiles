return {
  -- Copilot
  { 
    "github/copilot.vim",
    init = function()
      -- markdownとgitcommitでもcopilotを使えるようにする
      vim.g.copilot_filetypes = { markdown = true, gitcommit = true }
    end,
  },
}
