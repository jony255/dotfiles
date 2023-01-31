local nvim_treesitter_cfgs = require('nvim-treesitter.configs')

local M = {}

local function setup_treesitter_plugin()
    nvim_treesitter_cfgs.setup {
        ensure_installed = 'all',
        highlight = {
            enable = true, -- false will disable the whole extension
            disable = { 'gitcommit' },
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<CR>',
                node_incremental = '<CR>',
                scope_incremental = '<S-CR>',
                node_decremental = '<BS>',
            },
        },
        indent = {
            enable = true,
        },
        playground = {
            enable = true,
            disable = {},
            updatetime = 1, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
        },
        query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = { 'BufWrite', 'CursorHold' },
        },
    }
end

local function setup_treesitter_folds()
    -- https://github.com/nvim-treesitter/nvim-treesitter#folding
    -- The nvim documentation (h: vim.o) says to use vim.o when you want to
    -- 'Get or set editor options, like :set' Which is what the link above
    -- does.
    --     set foldmethod=expr
    --     set foldexpr=nvim_treesitter#foldexpr()
    -- However the link does say that:
    --     Tree-sitter based folding.
    --         (Technically not a module because it's per windows and not per buffer.)
    -- Another thing to note is that (h: foldnestmax) says that its local to the window
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.wo.foldnestmax = 2
end

function M.setup()
    setup_treesitter_plugin()
    setup_treesitter_folds()
end

return M
