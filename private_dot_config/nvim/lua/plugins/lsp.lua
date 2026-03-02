return {
  -- 1) Mason：安裝管理
  {
    "williamboman/mason.nvim",
    config = true,
  },

  -- 2) Mason 與 LSP 串接
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local mason_lsp = require("mason-lspconfig")
      mason_lsp.setup({
        ensure_installed = { "clangd", "pyright" },
        automatic_installation = true,

        -- ✅ 用 handlers（寫在 setup 裡）取代 setup_handlers，避免 nil
        handlers = (function()
          local lspconfig = require("lspconfig")
          local util = require("lspconfig.util")

          -- 建議：若你有 nvim-cmp，換成 cmp_nvim_lsp 的 capabilities
          -- local capabilities = vim.lsp.protocol.make_client_capabilities()
          local capabilities = require("cmp_nvim_lsp").default_capabilities()

          local function get_python()
            local cwd = vim.fn.getcwd()
            local venv = cwd .. "/.venv/bin/python"
            if vim.loop.fs_stat(venv) then return venv end
            return vim.fn.exepath("python3") or "python3"
          end

          return {
            -- 預設處理器：所有 server 共用的最小設定
            function(server_name)
              lspconfig[server_name].setup({
                capabilities = capabilities,
              })
            end,

            -- clangd：保留你原先的客製
            ["clangd"] = function()
              lspconfig.clangd.setup({
                cmd = { "clangd" },
                capabilities = capabilities,
                filetypes = { "c", "cpp", "objc", "objcpp" },
                root_dir = util.root_pattern(".clangd", ".git", "compile_commands.json"),
                -- 需要可加：
                -- cmd = { "clangd", "--background-index", "--clang-tidy" },
              })
            end,

            -- pyright：Python LSP
            ["pyright"] = function()
              lspconfig.pyright.setup({
                capabilities = capabilities,
                root_dir = util.root_pattern(
                  "pyproject.toml",
                  "setup.py",
                  "setup.cfg",
                  "requirements.txt",
                  ".git"
                ),
                before_init = function(_, config)
                  config.settings = config.settings or {}
                  config.settings.python = config.settings.python or {}
                  config.settings.python.pythonPath = get_python()
                end,
                settings = {
                  python = {
                    analysis = {
                      typeCheckingMode = "basic", -- 可改 "strict"/"off"
                      autoImportCompletions = true,
                      useLibraryCodeForTypes = true,
                    },
                  },
                },
              })
            end,
          }
        end)(),
      })
    end,
  },

  -- 3) LSP 本體：診斷 UI
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.diagnostic.config({
        virtual_text = { prefix = "●", spacing = 2 },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },
}
