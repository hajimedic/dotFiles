return {
  -- LSP周りのセットアップ (syntasticの代替)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- 補完連携用
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ts_ls", "eslint" }, -- python, js向け
        automatic_installation = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Neovim 0.11+ の新しいAPIを使用
      if vim.fn.has("nvim-0.11") == 1 then
        -- 全てのサーバーに対してデフォルトの capabilities を設定
        vim.lsp.config("*", { capabilities = capabilities })

        local servers = { "pyright", "ts_ls", "eslint" }
        for _, lsp in ipairs(servers) do
          vim.lsp.enable(lsp)
        end
      else
        -- 0.10以前のためのフォールバック
        local lspconfig = require("lspconfig")
        local servers = { "pyright", "ts_ls", "eslint" }
        for _, lsp in ipairs(servers) do
          lspconfig[lsp].setup({
            capabilities = capabilities,
          })
        end
      end
      
      -- LSP関連のキーマップ
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover Documentation" })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Go to References" })
      vim.keymap.set('n', 'rn', vim.lsp.buf.rename, { desc = "Rename Symbol" })
    end,
  },

  -- フォーマッター (Linterも一部兼ねる)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<C-s>",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
          vim.cmd("write")
        end,
        mode = "n",
        desc = "Format and Save",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "isort", "black" },
          javascript = { "prettier", "eslint_d" },
        },
      })
    end,
  },

  -- 補完エンジン
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enterで補完確定
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
