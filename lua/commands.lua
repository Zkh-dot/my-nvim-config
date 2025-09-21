-- твой модуль, как и просил
local ok, my_custom_funcs = pcall(require, "my_funcs")
if ok then
  vim.api.nvim_create_user_command("MyHelp", my_custom_funcs.open_myhelp, {})
end

-- мелкая вспомогательная команда из твоего примера
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
