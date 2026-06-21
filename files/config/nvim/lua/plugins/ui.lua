return {
  -- ステータスライン (lightlineの代替)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = "tokyonight",
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
        },
      })
    end,
  },

  -- ファイラー (vimfilerの代替)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<C-w><C-e>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 50,
        },
        filters = {
          custom = { "^\\.git$", "\\.pyo$", "\\.mo$", "\\.pyc$" }, -- vimfiler_ignore_patternの移植
        },
      })
    end,
  },

  -- Git差分表示
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Undoツリー表示 (gundo.vimの代替)
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" },
    },
  },
}
