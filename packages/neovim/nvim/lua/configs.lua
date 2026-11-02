

vim.opt.encoding      = "utf-8"       -- set encoding
vim.opt.termguicolors = false         -- true color support

-- fold
-- zM - all collapse
-- zR - all reveal
-- za - toggle
vim.opt.foldmethod    = "indent"
vim.opt.mouse         = ""            -- disable mouse
vim.opt.clipboard     = ""            -- disable shareable OS clipboard
vim.opt.expandtab     = true          -- Use spaces instead of tabs
vim.opt.shiftwidth    = 4             -- Size of an indent
vim.opt.tabstop       = 4             -- Number of spaces tabs count for
vim.opt.shiftround    = true          -- Round indent
vim.opt.spelllang     = { "en" }
vim.opt.splitbelow    = true          -- Put new windows below current
vim.opt.splitright    = true          -- Put new windows right of current
vim.opt.colorcolumn   = "80"          -- mark chars limit
vim.opt.showmode      = false         -- Dont show mode since we have a statusline
vim.opt.autoindent    = true          -- 
vim.opt.smartindent   = true          -- 
vim.opt.wrap          = false         -- dont wrap lines

-- set theme to bat (fzf preview)
vim.cmd([[ let $BAT_THEME='TokyoNordStorm' ]])
vim.g["airline#extensions#branch#enabled"] = 0

