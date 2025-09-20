-- ~/.config/nvim/init.lua

-- 設定 <leader> 鍵為空白鍵（需在最前面）
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 全域快捷鍵
-- 用來把錯誤訊息顯示在彈出的氣泡窗內
vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(0, { scope = "line", border = "rounded", severity_sort = true })
end, { desc = "Show diagnostics for current line", silent = true })

-- 關閉搜尋高亮
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = true })

-- 前或後移動到錯誤發生處
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- 會分割一個視窗顯示訊息
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })



-- ╭────────────────────────────────────────────╮
-- │ lazy.nvim 插件管理器初始化               │
-- ╰────────────────────────────────────────────╯
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ╭────────────────────────────────────────────╮
-- │ 插件載入                                   │
-- ╰────────────────────────────────────────────╯
require("lazy").setup({
    -- 主題與外觀
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- LSP 支援
  { "williamboman/mason.nvim", version = "v1.10.0" },
  { "williamboman/mason-lspconfig.nvim", version = "v1.29.0" },
  { "neovim/nvim-lspconfig", version = "v0.1.7" },
  -- 自動補全
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "L3MON4D3/LuaSnip",

  -- 自動補全括號
  -- ✅ 插件會在進入 Insert 模式時才被載入
  { "windwp/nvim-autopairs", event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  -- Treesitter 語法高亮
  { "nvim-treesitter/nvim-treesitter",
    version = "v0.9.2",
    build = ":TSUpdate" 
  },

  -- 檔案搜尋
  "nvim-lua/plenary.nvim", -- 放第一，保證先載入
  "nvim-telescope/telescope.nvim",
 
-- ╭────────────────────────────────────────────╮
-- │ NvimTree 檔案總管                          │
-- ╰────────────────────────────────────────────╯
  {"nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({
            view = {
                width = 30,
                side = "left",
            },
            filters = {
                git_ignored = false;
            },
            actions = {
                open_file = {
                    quit_on_open = false,
                    resize_window = true,
                },
            },
        })
        vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end,
  },

  -- 額外工具
  "tpope/vim-commentary",
  "tpope/vim-surround",
  "tpope/vim-fugitive",
})

-- ╭────────────────────────────────────────────╮
-- │ Neovim 基礎設定                            │
-- ╰────────────────────────────────────────────╯
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.termguicolors = true
vim.cmd.colorscheme("catppuccin-macchiato")

-- ╭────────────────────────────────────────────╮
-- │ mason & LSP                                │
-- ╰────────────────────────────────────────────╯
require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})

-- ╭────────────────────────────────────────────╮
-- │ nvim-cmp 自動補全                          │
-- ╰────────────────────────────────────────────╯
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})

-- ╭────────────────────────────────────────────╮
-- │ Treesitter 高亮                           │
-- ╰────────────────────────────────────────────╯
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc" },
  highlight = { enable = true },
})


-- ╭────────────────────────────────────────────╮
-- │ Telescope 搜尋工具                         │
-- ╰────────────────────────────────────────────╯
-- 就會打開一個可以搜尋檔案的彈窗
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true })
-- 打開全專案搜尋（支援正則、關鍵字）
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true })

