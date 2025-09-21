local lsp = require("lspconfig")
local capabilities = vim.g.cmp_capabilities or require("cmp_nvim_lsp").default_capabilities()

-- Mason
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "gopls",
    "pyright",
    "ruff_lsp",
    "rust_analyzer",
  },
})

-- clangd
lsp.clangd.setup({
  capabilities = capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy" },
})

-- Go
lsp.gopls.setup({
  capabilities = capabilities,
  settings = {
    gopls = {
      usePlaceholders = true,
      staticcheck = true,
      gofumpt = true,
      completeUnimported = true,
    },
  },
})

-- Python
lsp.pyright.setup({
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoImportCompletions = true,
      },
    },
  },
})

lsp.ruff_lsp.setup({
  capabilities = capabilities,
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
  end,
})

-- Rust через rustaceanvim (он сам поднимает rust-analyzer)
-- глобальные настройки rustaceanvim через vim.g
vim.g.rustaceanvim = {
  server = {
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        check = { command = "clippy" },
        inlayHints = { locationLinks = false },
      },
    },
  },
  tools = {
    float_win_config = { border = "rounded" },
  },
  dap = {
    -- codelldb будет подключён из mason в dap.lua
    autoload_configurations = false,
  },
}
