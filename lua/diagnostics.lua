-- lsp_lines: включить и синхронизировать с virtual_text
require("lsp_lines").setup()

-- из коробки выключаем virtual_text, когда используем lsp_lines
vim.diagnostic.config({ virtual_text = false })

-- переключатель строк/виртуального текста — нормальный режим
vim.keymap.set("n", "<leader>dl", function()
  local enabled = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = enabled, virtual_text = not enabled })
end, { desc = "Toggle lsp_lines" })

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  float = { border = "rounded", source = "if_many" },
})
