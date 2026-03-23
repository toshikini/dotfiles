return {
  {
    -- LSPサーバーマネージャー
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    -- コマンド実行時に遅延読み込み
    cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
    -- require("mason").setup() を自動実行
    config = true,
  },

  {
    -- LSPサーバーの設定と連携
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    -- ファイルを開いた時に読み込み
    event = { "BufReadPre", "BufNewFile" },
    -- キーバインド
    keys = {
      { "<C-space>", "<csonmd>lua vim.lsp.completion.get()<CR>", mode = "i", desc = "手動補完トリガー" },
      { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>",  desc = "定義へジャンプ" },
      { "M",  "<cmd>lua vim.lsp.buf.hover()<CR>",       desc = "ドキュメント表示" },
      { "gr", "<cmd>lua vim.lsp.buf.references()<CR>",  desc = "参照箇所を表示" },
      { "<Leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "名前の変更" },
      { "ge", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "エラー詳細を表示" },
    },
    
    config = function()
      -- 補完メニューの設定
      vim.opt.completeopt = {
        "fuzzy",    -- あいまい検索
        "popup",    -- 詳細をポップアップ表示
        "menuone",  -- 候補が1つでも表示
        "noinsert", -- 自動挿入しない
      }

      -- インストールするLSPサーバー
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls", "rust_analyzer", "gopls", "html", "cssls", 
          "htmx", "ruby_lsp", "pyright", "lua_ls",
        },
      })

      -- LSPアタッチ時の処理
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

          -- 自動補完
          if client:supports_method('textDocument/completion') then
            -- どんな文字を打っても補完をトリガー
            local chars = {}
            for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            
            -- ネイティブ自動補完を有効化
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
          end

          -- 保存時の自動フォーマット
          if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              -- 競合を防ぐため clear=false
              group = vim.api.nvim_create_augroup('my.lsp.format', { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 3000 })
              end,
            })
          end
        end,
      })
    end,
  },
}
