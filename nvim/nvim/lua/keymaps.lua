vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
local map = vim.api.nvim_set_keymap

--"fzf shortcut
map("n", "<C-p>", "<cmd>GFiles<cr>", { desc = "Fuzzy Finder Git files" })
map("n", "<C-g>", "<cmd>RG<cr>", { desc = "FZF rg search result; relaunch ripgrep on every keystroke" })
map("n", "<leader>p", "<cmd>Files<cr>", { desc = "Fuzzy Finder files" })

--" toggle comments (ctrl + /)
map("n", "<C-_>", "<cmd>CommentToggle<cr>", { desc = "Toggle Comment" })

--"reindent
map("n", "<F9>", "gg=G", { desc = "reindent" })

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

