require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c","cpp","cmake","json","lua","vim","vimdoc",
    "go","gomod","gosum","gowork",
    "python",
    "rust","toml",
  },
  highlight = { enable = true },
  indent = { enable = true },
})
