local lsp = require('lsp-zero')
local cmp = require('cmp')
local cmp_select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
        sources = {
            {name = 'nvim_lsp'},
        },
        mapping = {
            ['<CR>'] = cmp.mapping.confirm({select = true}),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select_opts),
            ['<Tab>'] = cmp.mapping.select_next_item(cmp_select_opts),
            ['<C-p>'] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.select_prev_item(cmp_select_opts)
                else
                    cmp.complete()
                end
            end),
            ['<C-n>'] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.select_next_item(cmp_select_opts)
                else
                    cmp.complete()
                end
            end),
        },
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        window = {
            documentation = {
                max_height = 15,
                max_width = 60,
            }
        },
        formatting = {
            fields = {'abbr', 'menu', 'kind'},
            format = function(entry, item)
                local short_name = {
                    nvim_lsp = 'LSP',
                    nvim_lua = 'nvim'
                }

                local menu_name = short_name[entry.source.name] or entry.source.name

                item.menu = string.format('[%s]', menu_name)
                return item
            end,
        },
    })

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = true})
end)


-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

require('mason').setup()
require('mason-lspconfig').setup({
        ensure_installed = {
            'clangd',
            'bashls',
            'lua_ls',
            'intelephense',
            'pyright',
            'dockerls',
            'docker_compose_language_service',
        },

        handlers = {
            function(server_name)
                require('lspconfig')[server_name].setup({})
            end,
        },

    })
lsp.setup()

