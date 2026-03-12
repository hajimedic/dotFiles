local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 独自のLeaderキー設定（他の設定より前に読み込まれる必要があります）
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Coreの設定を読み込み
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- プラグインの読み込み
require("lazy").setup("plugins", {
  checker = { enabled = true }, -- 自動アップデートチェック
})
