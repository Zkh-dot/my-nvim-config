-- починить End, который распознаётся как <Select>
vim.keymap.set({ "n", "i", "v" }, "<Select>", "<End>", { silent = true })
-- (иногда End приходит как ESC[4~ или ESC[F) — подстрахуем:
vim.keymap.set({ "n", "i", "v" }, "<Esc>[4~", "<End>", { silent = true })
vim.keymap.set({ "n", "i", "v" }, "<Esc>[F",  "<End>", { silent = true })

-- если Ctrl-стрелки начинают приходить как ESC[1;5D / ESC[1;5C:
vim.keymap.set({ "n","i","v" }, "<Esc>[1;5D", "<C-Left>",  { silent = true })
vim.keymap.set({ "n","i","v" }, "<Esc>[1;5C", "<C-Right>", { silent = true })
-- если Home определяется как <Find>
vim.keymap.set({ "n", "i", "v" }, "<Find>", "<Home>", { silent = true })

-- частые escape-коды для Home
vim.keymap.set({ "n", "i", "v" }, "<Esc>[1~", "<Home>", { silent = true })
vim.keymap.set({ "n", "i", "v" }, "<Esc>[H",  "<Home>", { silent = true })

