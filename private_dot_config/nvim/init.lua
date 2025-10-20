-- 設定 leader 鍵
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 基礎設定
require("core.options")
require("core.keymaps")
require("core.lazy")
require("core.session")

