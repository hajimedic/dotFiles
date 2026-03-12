local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Use grep Command, when open cwindow
autocmd("QuickFixCmdPost", {
  pattern = "*grep*",
  command = "cwindow",
})

-- :e などでファイルを開く際にフォルダが存在しない場合は自動作成
autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      local confirm = vim.fn.input(string.format('"%s" does not exist. Create? [y/N]', dir))
      if string.match(confirm:lower(), "^y(es)?$") then
        vim.fn.mkdir(dir, "p")
      end
    end
  end,
})

-- インサートモードに入った時にカーソル行(列)の色を変更する
local cursor_color_group = augroup("vimrc_change_cursorline_color", { clear = true })
autocmd("InsertEnter", {
  group = cursor_color_group,
  pattern = "*",
  command = "highlight CursorLine ctermbg=22 guibg=#00875f | highlight CursorColumn ctermbg=22 guibg=#00875f",
})
autocmd("InsertLeave", {
  group = cursor_color_group,
  pattern = "*",
  command = "highlight CursorLine ctermbg=235 guibg=Grey20 | highlight CursorColumn ctermbg=235 guibg=Grey20",
})

-- アクティブウィンドウに限りカーソル行(列)を強調する
local cursor_active_group = augroup("vimrc_set_cursorline_only_active_window", { clear = true })
autocmd({ "VimEnter", "BufWinEnter", "WinEnter" }, {
  group = cursor_active_group,
  pattern = "*",
  command = "setlocal cursorline | setlocal cursorcolumn",
})
autocmd("WinLeave", {
  group = cursor_active_group,
  pattern = "*",
  command = "setlocal nocursorline | setlocal nocursorcolumn",
})

-- 外部で変更されたファイルを自動で読み直す (autoreadの強化)
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})
