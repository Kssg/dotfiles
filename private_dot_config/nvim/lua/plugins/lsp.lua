-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "williamboman/mason.nvim",
    config = true,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd" },
        automatic_installation = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      -- 🩺 診斷顯示設定
      vim.diagnostic.config({
        virtual_text = { prefix = "●", spacing = 2 },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- ✅ Neovim 0.11 官方推薦寫法
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- LSP 基本設定（會在 mason-lspconfig 安裝後自動啟動）
      local servers = {
        clangd = {
          cmd = { "clangd" },
          capabilities = capabilities,
          filetypes = { "c", "cpp", "objc", "objcpp" },
          root_dir = vim.fs.root(0, { ".clangd", ".git", "compile_commands.json" }),
        },
      }

      for name, config in pairs(servers) do
        -- 將 name 加入 table
        local cfg = vim.tbl_extend("force", { name = name }, config)
        vim.lsp.start(cfg)
      end
    end,
  },
}

