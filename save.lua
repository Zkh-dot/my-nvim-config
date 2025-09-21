-- leader
vim.g.mapleader = " "

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- базовые настройки
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

require("lazy").setup({
  -- LSP
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", build = ":MasonUpdate" },
  { "williamboman/mason-lspconfig.nvim" },

  -- автодополнение
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-buffer" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },

  -- treesitter (подсветка/структура кода)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- форматирование
  { "stevearc/conform.nvim" },

  -- DAP отладка
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

require("lsp_lines").setup()
-- выключаем обычный virtual_text, когда включены lsp_lines
vim.diagnostic.config({ virtual_text = false })
vim.keymap.set("", "<leader>dl", function()
  local enabled = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = enabled, virtual_text = not enabled })
end, { desc = "Toggle lsp_lines" })

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",   -- символ перед сообщением
    spacing = 2,    -- отступ от кода
  },
  signs = true,      -- значки в колонке слева
  underline = true,  -- подчёркивание ошибок
  update_in_insert = false,
  float = { border = "rounded", source = "if_many" },
})

local my_custom_funcs = require("my_funcs")
vim.api.nvim_create_user_command("MyHelp", my_custom_funcs.open_myhelp, {})

require("toggleterm").setup({
  size = 12,
  open_mapping = [[<C-\>]],
  direction = "horizontal",
  start_in_insert = true,
  shell = vim.o.shell,
})

vim.keymap.set("n", "<leader>`", "<Cmd>ToggleTerm<CR>", { desc = "Toggle terminal bottom" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Mason (установка LSP/форматтеров/отладчиков)
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "gopls",
    "pyright",
    "ruff_lsp",   -- быстрые диагностики и фиксы для Python
  },
})


-- nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
  },
})

-- LSP: clangd
local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig").clangd.setup({
  capabilities = capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy" },
})

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

-- Python: Pyright + Ruff (диагностики и быстрые фиксы)
lsp.pyright.setup({
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- можно "strict"
        autoImportCompletions = true,
      },
    },
  },
})
lsp.ruff_lsp.setup({
  capabilities = capabilities,
  on_attach = function(client, _)
    -- пусть hover/тип даёт Pyright, а Ruff — только диагностики/фиксы
    client.server_capabilities.hoverProvider = false
  end,
})
-- Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c","cpp","cmake","json","lua","vim","vimdoc",
    "go","gomod","gosum","gowork",
    "python",
  },
  highlight = { enable = true },
  indent = { enable = true },
})

-- форматирование через conform + clang-format
require("conform").setup({
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    go = { "goimports", "gofmt" },      -- или {"gofumpt"} если хочешь строгий стиль
    python = { "black", "isort" },      -- или {"ruff_format"} если юзаешь Ruff как форматтер
  },
  format_on_save = { lsp_fallback = false, timeout_ms = 1000 },
})

-- DAP (codelldb через Mason)
require("mason-nvim-dap").setup({ ensure_installed = { "codelldb" } })
local dap = require("dap")
local mason_path = vim.fn.stdpath("data") .. "/mason"
local codelldb = mason_path .. "/bin/codelldb"
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = { command = codelldb, args = { "--port", "${port}" } },
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}
dap.configurations.c = dap.configurations.cpp
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

-- статус-бар, навигатор, гит, файловое дерево
require("lualine").setup()
require("gitsigns").setup()
require("nvim-tree").setup()

-- полезные клавиши
local map = vim.keymap.set
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "File tree" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to def" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map({ "n", "v" }, "<leader>f", function() require("conform").format({ async = true }) end, { desc = "Format" })

-- colorscheme like vscode
vim.cmd.colorscheme("vscode")

vim.api.nvim_create_user_command("Tv", function(opts)
  local arg = opts.args
  if arg == "s" then
    vim.cmd("Telescope find_files")
  elseif arg == "g" then
    vim.cmd("Telescope live_grep")
  else
    print("tv: неизвестный аргумент")
  end
end, { nargs = 1 })

