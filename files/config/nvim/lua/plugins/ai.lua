return {
  -- 1. GitHub Copilot 本体 (Lua版で超高速)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-l>", -- Ctrl + l で提案を受け入れる
            next = "<M-]>",   -- Alt + ] で次の候補
            prev = "<M-[>",   -- Alt + [ で前の候補
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false },
      })
    end,
  },

  -- 2. Copilot Chat (エディタ内でチャット)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat Toggle" },
    },
  },
}
