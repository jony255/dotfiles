local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }

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
    buf_set_keymap('n', '<leader>dn', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<leader>dp', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

    -- Don't need ??
    --buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    --
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    local cfg = {
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        -- If you want to hook lspsaga or other signature handler, pls set to false
        doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
        -- set to 0 if you DO NOT want any API comments be shown
        -- This setting only take effect in insert mode, it does not affect signature help in normal
        -- mode, 10 by default

        floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
        hint_enable = false, -- virtual hint enable
        hint_scheme = "String",
        use_lspsaga = false,  -- set to true if you want to use lspsaga popup
        hi_parameter = "Search", -- how your parameter will be highlight
        max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
        -- to view the hiding contents
        max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
        handler_opts = {
            border = "shadow"   -- double, single, shadow, none
        },
        extra_trigger_chars = {} -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    }

    require'lsp_signature'.on_attach(cfg)

end

lsp_config = require'lspconfig'

-- Use ccls when switching to lsp-based highlighting, I don't think clangd can
--lsp_config.ccls.setup{
--    on_attach=on_attach,
--    init_options = {
--        highlight = {
--            lsRanges = true;
--        },
--    }
--}

-- Might be cleaner to try to expose this as a pattern from `lspconfig.util`, as
-- really it is just stolen from part of the `clangd` config
local function project_name_to_container_name()
    -- Notably _not_ including `compile_commands.json`, as we want the entire project
    local root_pattern = lsp_config.util.root_pattern('.git')

    -- Turn the name of the current file into the name of an expected container, assuming that
    -- the container running/building this file is named the same as the basename of the project
    -- that the file is in
    --
    -- The name of the current buffer
    local bufname = vim.api.nvim_buf_get_name(0)

    -- Turned into a filename
    local filename = lsp_config.util.path.is_absolute(bufname) and bufname or lsp_config.util.path.join(vim.loop.cwd(), bufname)

    -- Then the directory of the project
    local project_dirname = root_pattern(filename) or lsp_config.util.path.dirname(filename)

    -- And finally perform what is essentially a `basename` on this directory
    return vim.fn.fnamemodify(lsp_config.util.find_git_ancestor(project_dirname), ':t')
end

-- Note that via the `manager` from `server_per_root_dir_manager`, we'll get a separate instance
-- of `clangd` as we switch between files, or even projects, inside of the right container
--
-- Finally, we've formed the "basename of a project" to pass to our `cclangd` script, which will
-- then look for a matching container, or run `clangd` normally if no matching container is found
--    /path/to/my/project
-- would look for a container named `project`, and `docker exec` a `clangd` instance there, etc.
lsp_config["clangd"].setup {
    on_attach = on_attach,
    cmd = { "cclangd", project_name_to_container_name()},
}

lsp_config["rust_analyzer"].setup({
    on_attach=on_attach,
})

lsp_config["pylsp"].setup({
    on_attach=on_attach,
    settings = {
        pylsp = {
            configuration_sources = {"flake8", "pylint"},
            plugins = {
                flake8 = {
                    enabled = true,
                },
                pylint = {
                    enabled = true,
                },
            }
        }
    }
})


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
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
