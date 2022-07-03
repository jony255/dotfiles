local lsp_config = require('lspconfig')

local M = {}

function M.setup_keybindings(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    --buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --
    -- Doesn't work??
    --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    -- I need to learn how to best use these.
    --buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    -- Not supported by clangd
    --buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    --
    --buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)

    -- Don't need ??
    --buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    --
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
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
