require("conform").setup({
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    go = { "goimports", "gofmt" }, -- или {"gofumpt"}
    python = { "black", "isort" }, -- или {"ruff_format"}
    rust = { "rustfmt" },
    toml = { "taplo" },
  },
  format_on_save = { lsp_fallback = false, timeout_ms = 1000 },
})
