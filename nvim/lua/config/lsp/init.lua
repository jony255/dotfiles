local lsp_config = require('lspconfig')

local M = {}

function M.setup_keybindings(client, bufnr)
    --Enable completion triggered by <c-x><c-o>
    vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    -- Doesn't work??
    --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    -- I need to learn how to best use these.
    --vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    --vim.keymap.set('n', '<leader>wl', function()
    --    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --end, opts)

    -- Not supported by clangd
    --vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    --vim.keymap.set('n', '<leader>e', vim.lsp.diagnostic.show_line_diagnostics, opts)
    vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, opts)

    -- Don't need ??
    --vim.keymap.set('n', '<leader>q', vim.lsp.diagnostic.set_loclist, opts)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)
end

function M.setup(on_attach, capabilties)
    for _, server in ipairs { 'clangd', 'pylsp', 'rust-analyzer' } do
        require('config.lsp.' .. server).setup(lsp_config, on_attach, capabilties)
    end

    require('config.lsp.null_ls').setup(on_attach)

    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            -- This will disable virtual text, like doing:
            -- let g:diagnostic_enable_virtual_text = 0
            virtual_text = true,

            -- This is similar to:
            -- let g:diagnostic_show_sign = 1
            -- To configure sign display,
            --  see: ":help vim.lsp.diagnostic.set_signs()"
            signs = true,

            -- This is similar to:
            -- "let g:diagnostic_insert_delay = 1"
            update_in_insert = true,
        }
    )
end

return M
