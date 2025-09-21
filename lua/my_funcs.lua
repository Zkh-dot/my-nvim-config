local custom_funcs = {}

function custom_funcs.open_myhelp()
  local lines = {
    "MY HELP — быстрые команды",
    "",
    "Открыть папку:               :e ~/temp",
    "Открыть файл:                :e путь/к/файлу",
    "Создать новый файл:          :e имя_файла  → :w",
    "Создать файл (netrw):        %",
    "Создать файл (nvim-tree):    a",
    "",
    "Переключение между файлами:",
    "  предыдущий файл:           Ctrl-^  или  :e#",
    "  список буферов:            :ls  →  :bN, :bn, :bp",
    "  поиск файла (telescope):   :Telescope find_files",
    "  открытые буферы (tel):     :Telescope buffers",
    "",
    "Терминал (ToggleTerm):",
    "  открыть/закрыть:           :ToggleTerm  или  Ctrl-\\",
    "  уменьшить/увеличить:       Ctrl-w :resize -5 / +5",
    "  точный размер:             Ctrl-w :resize 15",
    "  выйти в normal из term:    Ctrl-\\ затем Ctrl-n",
    "",
    "Переход между окнами:",
    "  следующее окно:            Ctrl-w w",
    "  вниз/вверх/влево/вправо:   Ctrl-w j/k/h/l",
    "",
    "Диагностика LSP:",
    "  всплывашка под курсором:   gl",
    "  список диагностик (tel):   :Telescope diagnostics",
    "",
    "Автопары скобок:",
    "  плагин nvim-autopairs",
    "",
    "Копирование/вставка:",
    "  выделить строки:           V → j/k → y",
    "  вставить после/до:         p / P",
    "  весь файл в системный буфер:  :%y+",
    "",
    "Удаление:",
    "  все строки:                :%d  или  ggdG",
    "",
    "Отмена/повтор:",
    "  undo:                      u",
    "  redo:                      Ctrl-r",
  }
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"
  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.7)
  local row = math.floor((vim.o.lines - height) / 2 - 1)
  local col = math.floor((vim.o.columns - width) / 2)
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })
end

return custom_funcs
