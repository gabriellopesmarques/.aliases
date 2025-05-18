vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
local map = vim.api.nvim_set_keymap

--"fzf shortcut
map("n", "<C-p>", "<cmd>GFiles<cr>", { desc = "Fuzzy Finder Git files" })
map("n", "<C-b>", "<cmd>Buffers<cr>", { desc = "Fuzzy Finder Buffers" })
map("n", "<C-g>", "<cmd>RG<cr>", { desc = "FZF rg search result; relaunch ripgrep on every keystroke" })
map("n", "<A-x>", "<cmd>Commands<cr>", { desc = "Fuzzy Finder Commands" })
map("n", "<leader>p", "<cmd>Files<cr>", { desc = "Fuzzy Finder files" })

--" toggle comments (ctrl + /)
map("n", "<C-_>", "<cmd>CommentToggle<cr>", { desc = "Toggle Comment" })

--"reindent
map("n", "<F9>", "gg=G", { desc = "reindent" })

--" save as
map('n', '<leader>sa', '<cmd>lua require("my_functions").save_as_and_open()<CR>', { noremap = true, silent = true })

--" open current buffer in new tab
map('n', '<leader>tn', '<cmd>lua require("my_functions").tabnew_current_file()<CR>', { noremap = true, silent = true })

--"copy with OS clipboard
vim.cmd([[ vnoremap <silent><Leader>y "yy <Bar> :call system('xclip -sel clip', @y)<CR> ]])

--" fix typos
vim.cmd([[ command Vsp vsp ]])
vim.cmd([[ command Tabe tabe ]])
vim.cmd([[ command WQ wq ]])
vim.cmd([[ command Wq wq ]])
vim.cmd([[ command W w ]])
vim.cmd([[ command Q q ]])
vim.cmd([[ command E e ]])

