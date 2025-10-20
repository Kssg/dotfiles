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

