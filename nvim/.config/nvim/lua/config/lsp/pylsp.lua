local M = {}

function M.setup(lsp_config, on_attach, capabilities)
    lsp_config["pylsp"].setup {
        on_attach=on_attach,
        capabilities=capabilities,
        settings = {
            pylsp = {
                configuration_sources = {"flake8", "pylint"},
                plugins = {
                    flake8 = {
                        enabled = true,
                    },
                    pydocstyle = {
                        enabled = true,
                    },
                    pylint = {
                        enabled = true,
                    },
                    jedi_completion = {
                        cache_labels_for = {"wx"},
                    },
                }
            }
        }
    }
end

return M
