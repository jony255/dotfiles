-- Use ccls when switching to lsp-based highlighting, I don't think clangd can

local M = {}

function M.setup(lsp_config, on_attach, capabilities)
    lsp_config['ccls'].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
            highlight = {
                lsRanges = true,
            },
        },
    }
end

return M
