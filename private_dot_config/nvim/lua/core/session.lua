-- 📁 lua/core/session.lua

local session_dir = vim.fn.stdpath("state") .. "/sessions"
vim.fn.mkdir(session_dir, "p")

-- 根據目前工作目錄建立 session 名稱
local function get_session_path()
  local cwd = vim.fn.getcwd()
  local filename = cwd:gsub("[/:]", "_") .. ".vim"
  return session_dir .. "/" .. filename
end

-- 儲存 Session
local function save_session()
  local path = get_session_path()
  vim.cmd("mksession! " .. vim.fn.fnameescape(path))
  vim.notify("💾 Session saved: " .. path, vim.log.levels.INFO)
end

-- 載入 Session
local function restore_session()
  local path = get_session_path()
  if vim.fn.filereadable(path) == 1 then
    vim.cmd("silent! source " .. vim.fn.fnameescape(path))
    vim.notify("📂 Session restored: " .. path, vim.log.levels.INFO)
  else
    vim.notify("⚠️ No session found for this project", vim.log.levels.WARN)
  end
end

-- 刪除 Session
local function delete_session()
  local path = get_session_path()
  if vim.fn.delete(path) == 0 then
    vim.notify("🗑️ Session deleted: " .. path, vim.log.levels.INFO)
  else
    vim.notify("❌ No session file to delete", vim.log.levels.WARN)
  end
end

-- 定義指令
vim.api.nvim_create_user_command("SaveSession", save_session, {})
vim.api.nvim_create_user_command("RestoreSession", restore_session, {})
vim.api.nvim_create_user_command("DeleteSession", delete_session, {})

-- 離開前自動儲存
-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   callback = save_session,
-- })

-- 啟動時：只有在「沒開任何檔案」的情況才自動載入
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if vim.fn.argc() == 0 then
      restore_session()
    end
  end,
})

