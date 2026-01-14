-- Neovim 基本設定
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.termguicolors = true

-- 允許讀取專案本地設定檔（.nvim.lua / .exrc）
vim.opt.exrc = true
-- 啟用安全模式：未信任前不執行危險指令
vim.opt.secure = true

