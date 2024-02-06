local null_ls = require('null-ls')
local builtins = null_ls.builtins

local M = {}

function M.setup(on_attach)
    null_ls.setup {
        on_attach = on_attach,
        sources = {
            builtins.formatting.stylua,
            builtins.formatting.cmake_format,

            builtins.diagnostics.cmake_lint,
            builtins.diagnostics.luacheck,
            builtins.diagnostics.shellcheck,

            builtins.code_actions.shellcheck,
        },
    }
end

return M
