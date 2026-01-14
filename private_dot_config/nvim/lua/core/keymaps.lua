-- 全域快捷鍵設定

-- 顯示錯誤訊息氣泡
vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(0, {
    scope = "line",
    border = "rounded",
    severity_sort = true,
  })
end, { desc = "Show diagnostics for current line", silent = true })

-- 清除搜尋高亮
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = true })

-- 錯誤跳轉
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- 顯示錯誤列表
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

-- Telescope 快捷鍵
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true })


-- 搜索所有檔案（包含 hidden & no_ignore）
vim.keymap.set('n', '<leader>fF', function()
  require('telescope.builtin').find_files({ hidden = true, no_ignore = true })
end, { desc = 'Find all files (include ignored & hidden)' })

-- 全庫內容搜尋（包含 hidden & no_ignore）
vim.keymap.set('n', '<leader>fG', function()
  require('telescope.builtin').live_grep({
    additional_args = function() return { '--hidden', '--no-ignore' } end
  })
end, { desc = 'Search all (include ignored & hidden)' })

-- 直跳（快）
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { silent = true })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { silent = true })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { silent = true })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { silent = true })

-- 列表挑選（穩、好篩）
vim.keymap.set('n', '<leader>ld', '<cmd>Telescope lsp_definitions<cr>', { silent = true })
vim.keymap.set('n', '<leader>lr', '<cmd>Telescope lsp_references<cr>', { silent = true })
vim.keymap.set('n', '<leader>li', '<cmd>Telescope lsp_implementations<cr>', { silent = true })
vim.keymap.set('n', '<leader>lt', '<cmd>Telescope lsp_type_definitions<cr>', { silent = true })

