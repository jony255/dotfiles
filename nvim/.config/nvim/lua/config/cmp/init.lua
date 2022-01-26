local cmp = require'cmp'

local M = {}

local function setup_cmp()
    cmp.setup {
        mapping = {
            ['<C-Space>'] = cmp.mapping.complete(),

            -- cmp.SelectBehavior.Insert = inserts completion into buffer when cycling through completions
            -- cmp.SelectBehavior.Select = insert completion into buffer ONLY when you confirm the selection
            ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),

            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),

            ['<C-e>'] = cmp.mapping.close(),
            -- Confirm the selection so the server can apply additional text edits
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                -- true = hitting enter when the completion menu pops up automatically
                --        inserts the first item in the list, even though it wasn't
                --        explicitly selected
                --
                -- false = insert the completion only if has been selected in the
                --         completion menu
                select = false,
            }),
        },
        sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'ultisnips' },
                { name = 'buffer' },
                { name = 'dictionary', keyword_length = 2 },
                { name = 'path' },
        }),
        formatting = {
            format = function(entry, vim_item)
                vim_item.menu = ({
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[NVIM-LUA]',
                    ultisnips = '[UltiSnips]',
                    buffer = '[Buf]',
                    dictionary = '[dict]',
                })[entry.source.name]

                return vim_item
            end,
        },
        snippet = {
            expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body)
            end,
        },
    }
end

function M.setup()
    setup_cmp()
    require('config.cmp.cmdline').setup(cmp)
    require('config.cmp.dictionary').setup()
end

local cmp_nvim_lsp = require('cmp_nvim_lsp')

M.capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

return M
