local map = vim.keymap.set

-- telescope / nvim-tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "File tree" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep" })

-- LSP common
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to def" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map({ "n", "v" }, "<leader>f", function() require("conform").format({ async = true }) end, { desc = "Format" })
