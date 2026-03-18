-- 📁 lua/core/session.lua

local session_dir = vim.fn.stdpath("state") .. "/sessions"
vim.fn.mkdir(session_dir, "p")

-- 根據目前工作目錄建立 session 名稱
local function get_session_path(cwd)
  cwd = cwd or vim.fn.getcwd()
  local filename = cwd:gsub("[/:]", "_") .. ".vim"
  return session_dir .. "/" .. filename
end

-- 從 session 檔案讀取原始 cwd（從註解）
local function read_session_cwd(path)
  local lines = vim.fn.readfile(path)
  for i = #lines, math.max(#lines - 10, 1), -1 do
    local cwd = lines[i]:match('^"%s*cwd:%s*(.+)')
    if cwd then
      return cwd
    end
  end
  return "unknown"
end

-- 儲存 Session
local function save_session()
  local cwd = vim.fn.getcwd()
  local path = get_session_path(cwd)

  vim.cmd("mksession! " .. vim.fn.fnameescape(path))

  -- 在檔案最後面寫入人類可讀資訊
  vim.fn.writefile({
    '" cwd: ' .. cwd,
    '" saved: ' .. os.date("%Y-%m-%d %H:%M:%S"),
  }, path, "a")

  vim.notify("💾 Session saved: " .. cwd, vim.log.levels.INFO)
end

-- 載入目前 cwd 的 Session
local function restore_session()
  local path = get_session_path()
  if vim.fn.filereadable(path) == 1 then
    vim.cmd("silent! source " .. vim.fn.fnameescape(path))
    vim.notify("📂 Session restored", vim.log.levels.INFO)
  else
    vim.notify("⚠️ No session found for this directory", vim.log.levels.WARN)
  end
end

-- 刪除目前 cwd 的 Session
local function delete_session()
  local path = get_session_path()
  if vim.fn.delete(path) == 0 then
    vim.notify("🗑️ Session deleted", vim.log.levels.INFO)
  else
    vim.notify("❌ No session file to delete", vim.log.levels.WARN)
  end
end

-- 📚 列出所有 Sessions（含 cwd）
local function list_sessions()
  local files = vim.fn.glob(session_dir .. "/*.vim", false, true)

  if #files == 0 then
    vim.notify("📭 No sessions found", vim.log.levels.INFO)
    return
  end

  for _, path in ipairs(files) do
    local fname = vim.fn.fnamemodify(path, ":t")
    local cwd = read_session_cwd(path)
    vim.notify(string.format("📁 %s → %s", fname, cwd))
  end
end

-- 🔍 選擇並還原 Session（顯示 cwd）
local function pick_session()
  local files = vim.fn.glob(session_dir .. "/*.vim", false, true)
  if #files == 0 then
    vim.notify("📭 No sessions found", vim.log.levels.INFO)
    return
  end

  local items = {}
  for _, path in ipairs(files) do
    table.insert(items, {
      path = path,
      cwd = read_session_cwd(path),
      name = vim.fn.fnamemodify(path, ":t"),
    })
  end

  vim.ui.select(items, {
    prompt = "Restore session:",
    format_item = function(item)
      return string.format("%s  [%s]", item.name, item.cwd)
    end,
  }, function(choice)
    if choice then
      vim.cmd("silent! source " .. vim.fn.fnameescape(choice.path))
      vim.notify("📂 Session restored: " .. choice.cwd, vim.log.levels.INFO)
    end
  end)
end

-- User Commands
vim.api.nvim_create_user_command("SaveSession", save_session, {})
vim.api.nvim_create_user_command("RestoreSession", restore_session, {})
vim.api.nvim_create_user_command("DeleteSession", delete_session, {})
vim.api.nvim_create_user_command("ListSessions", list_sessions, {})
vim.api.nvim_create_user_command("PickSession", pick_session, {})

-- 啟動時：僅在沒有傳入檔案時自動 restore
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if vim.fn.argc() == 0 then
      restore_session()
    end
  end,
})
