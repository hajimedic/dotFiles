return {
  {
    "sainnhe/gruvbox-material", -- Wombatに近く、モダンで人気のあるカラースキームとして導入
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.cmd.colorscheme("gruvbox-material")

      -- 旧 highlight.vim の設定を移植
      local hl = vim.api.nvim_set_hl
      
      hl(0, "Comment", { ctermfg = 2, fg = "#5f8700" })
      hl(0, "ColorColumn", { ctermbg = 236, bg = "#303030" })
      hl(0, "CursorLine", { ctermbg = 235, bg = "#262626" })
      hl(0, "Directory", { bold = true, ctermfg = 7, fg = "#c0c0c0" })
      hl(0, "Identifier", { ctermfg = 3, fg = "#808000" })
      hl(0, "LineNr", { ctermfg = 7, fg = "#c0c0c0" })
      hl(0, "Pmenu", { ctermfg = 16, fg = "#000000" })
      hl(0, "Search", { ctermbg = 240, bg = "#585858" })
      hl(0, "Statement", { ctermfg = 1, fg = "#800000" })
      hl(0, "Special", { ctermfg = 1, fg = "#800000" })
      hl(0, "SpecialKey", { ctermfg = 235, fg = "#262626" })
      hl(0, "SignColumn", { ctermbg = 0, bg = "#000000" })
      hl(0, "Todo", { ctermfg = 11, ctermbg = 0, fg = "#ffff00", bg = "#000000" })
      hl(0, "CursorColumn", { ctermbg = 235, bg = "#262626" })
      hl(0, "Constant", { ctermfg = 6, fg = "#008080" })
      hl(0, "DiffChange", { ctermbg = 235, bg = "#262626" })
      hl(0, "DiffAdd", { ctermbg = 17, bg = "#00005f" })
      hl(0, "DiffDelete", { ctermbg = 52, bg = "#5f0000" })
      hl(0, "StatusLine", { ctermfg = 208, ctermbg = 0, fg = "#ff8700", bg = "#000000" })
      hl(0, "PreProc", { ctermfg = 5, fg = "#800080" })
    end,
  }
}
