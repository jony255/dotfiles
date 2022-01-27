local cmp_cfg = require('config.cmp')
local lsp_cfg = require('config.lsp')
local lsp_signature_cfg = require('config.lsp_signature')
local treesitter_cfg = require('config.treesitter')

local M = {}

local on_attach = function(client, bufnr)
    lsp_cfg.setup_keybindings(client, bufnr)

    lsp_signature_cfg.setup()
end

function M.setup()
    cmp_cfg.setup()
    lsp_cfg.setup(on_attach, cmp_cfg.capabilities)

    treesitter_cfg.setup()
end

return M
