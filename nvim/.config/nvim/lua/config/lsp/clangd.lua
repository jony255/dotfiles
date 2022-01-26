local M = {}

-- Might be cleaner to try to expose this as a pattern from `lspconfig.util`, as
-- really it is just stolen from part of the `clangd` config
local function project_name_to_container_name(lsp_config)
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

function M.setup(lsp_config, on_attach, capabilities)
    lsp_config["clangd"].setup {
        on_attach=on_attach,
        capabilities=capabilities,
        cmd = { "cclangd", project_name_to_container_name(lsp_config) },
    }
end

return M
