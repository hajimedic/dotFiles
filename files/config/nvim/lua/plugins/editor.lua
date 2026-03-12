return {
  -- ファジーファインダー (unite.vimの代替)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-w><C-b>", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
      { "<C-w><C-t>", "<cmd>Telescope help_tags<CR>", desc = "Help tags (代用)" },
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { ".git/", "__pycache__/", "%.pyc" },
        },
      })
    end,
  },

  -- ヤンク履歴 (yankroundの代替)
  {
    "gbprod/yanky.nvim",
    keys = {
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" } },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" } },
      { "<C-n>", "<Plug>(YankyCycleForward)", mode = "n" },
      { "<C-p>", "<Plug>(YankyCycleBackward)", mode = "n" },
      { "<leader>p", "<cmd>Telescope yank_history<CR>", mode = "n", desc = "Yank History" },
    },
    config = function()
      require("yanky").setup({
        ring = { history_length = 100 },
      })
      require("telescope").load_extension("yank_history")
    end,
  },

  -- コメントアウト (tcomment_vimの代替)
  {
    "numToStr/Comment.nvim",
    keys = {
      { "\\x", "gcc", remap = true, desc = "Toggle comment line" },
      { "\\x", "gc", mode = "v", remap = true, desc = "Toggle comment block" },
      { "\\a", "yygccp", remap = true, desc = "Yank, comment and paste" },
    },
    config = function()
      require("Comment").setup()
    end,
  },

  -- Git連携 (引き続き使用)
  {
    "tpope/vim-fugitive",
  },
}
