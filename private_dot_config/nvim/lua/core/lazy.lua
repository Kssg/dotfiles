-- lazy.nvim 初始化（引導程式）
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim 主設定：從 plugins 資料夾中載入模組
require("lazy").setup({
  spec = {
    { import = "plugins.theme" },
    { import = "plugins.lsp" },
    { import = "plugins.treesitter" },
    { import = "plugins.telescope" },
    { import = "plugins.nvimtree" },
    { import = "plugins.cmp" },
    { import = "plugins.misc" }, -- ← 這裡包含 autopairs / fugitive / commentary / surround
    { improt = "plugins.markdown" },
  },
  checker = { enabled = false },
})


