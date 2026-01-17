-- lazy.nvim plugins manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


local plugins = {
    -- theme
    {
        'arcticicestudio/nord-vim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme nord]])
        end,
    },
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = function()
            require("git-conflict").setup()
        end
    },


    'tpope/vim-fugitive',

    'jwalton512/vim-blade',

    -- status bar
    'vim-airline/vim-airline',

    -- fuzzy finder
    'junegunn/fzf',
    'junegunn/fzf.vim',

    'lewis6991/gitsigns.nvim',
    'terrortylor/nvim-comment',

    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate'
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
             --LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }
}
local opts = {}

require("lazy").setup(plugins, opts)
require('nvim_comment').setup()
require("plugins.gitsigns")
require("plugins.lsp")

