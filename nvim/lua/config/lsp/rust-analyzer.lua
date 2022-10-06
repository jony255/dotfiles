local M = {}

function M.setup(lsp_config, on_attach, capabilities)
    lsp_config['rust_analyzer'].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'rrust-analyzer' },
        settings = {
            ['rust-analyzer'] = {
                assist = {
                    importGranularity = 'module',
                    importPrefix = 'by_self',
                },
                cargo = {
                    loadOutDirsFromCheck = true,
                },
                procMacro = {
                    enable = true,
                },
                checkOnSave = {
                    allFeatures = true,
                    overrideCommand = {
                        'cargo',
                        'clippy',
                        '--workspace',
                        '--message-format=json',
                        '--all-targets',
                        '--all-features',
                        '--',
                        '-W',
                        'clippy::pedantic',
                    },
                },
            },
        },
    }
end

return M
