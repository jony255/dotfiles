local M = {}

function M.setup()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            "bash",
            "c",
            "cmake",
            "comment",
            "cpp",
            "dockerfile",
            "fish",
            "json",
            "kotlin",
            "lua",
            "nix",
            "python",
            "query",
            "regex",
            "rust",
            "toml",
            "yaml",
            "zig",
        },
        highlight = {
            enable = true,    -- false will disable the whole extension
        },
        indent = {
            enable = true,
        },
        playground = {
            enable = true,
            disable = {},
            updatetime = 1, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false -- Whether the query persists across vim sessions
        },
        query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = {"BufWrite", "CursorHold" },
        },
    }


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

return M
