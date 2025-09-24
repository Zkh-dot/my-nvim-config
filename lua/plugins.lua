require("lazy").setup({
  -- LSP + менеджеры
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", build = ":MasonUpdate" },
  { "williamboman/mason-lspconfig.nvim" },

  -- Rust: современный набор
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- стабильная ветка
    ft = { "rust" },
  },

  -- автодополнение
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-buffer" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },


  -- treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- форматирование
  { "stevearc/conform.nvim" },

  -- DAP
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
  { "williamboman/mason-nvim-dap.nvim" },

  -- утилиты
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-lualine/lualine.nvim" },
  { "lewis6991/gitsigns.nvim" },
  { "nvim-tree/nvim-tree.lua" },
  { "akinsho/toggleterm.nvim", version = "*" },
  { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

  { "windwp/nvim-autopairs", config = true },
  { "Mofiqul/vscode.nvim" },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
})
