require("toggleterm").setup({
  size = 12,
  open_mapping = [[<C-\>]],
  direction = "horizontal",
  start_in_insert = true,
  shell = vim.o.shell,
})

vim.keymap.set("n", "<leader>`", "<Cmd>ToggleTerm<CR>", { desc = "Toggle terminal bottom" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
