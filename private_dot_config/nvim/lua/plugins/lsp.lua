-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim", config = true },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- 設定診斷顯示
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",          -- 可以改成 ►、●、■ 等符號
          spacing = 2,           -- 訊息和行號之間的空格
          severity = { min = vim.diagnostic.severity.INFO },
        }, -- 顯示所有嚴重程度
        signs = true,             -- 顯示行號旁的 E/W
        underline = true,         -- 有底線標示
        update_in_insert = false, -- 插入模式不更新，避免打字時跳動
        severity_sort = true,     -- 錯誤訊息依嚴重度排序
      })

      -- 透過 mason-lspconfig 安裝的 LSP servers
      local servers = { "clangd" }

      for _, lsp in ipairs(servers) do
        vim.lsp.start({
          name = lsp,
        })
      end
    end,
  },
}

