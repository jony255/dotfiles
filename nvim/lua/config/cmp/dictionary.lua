local M = {}

local cmp_dictionary = require('cmp_dictionary')

function M.setup()
    cmp_dictionary.setup {
        exact_length = 2,
        first_case_insensitive = true,
        async = true,
        debug = false,
        paths = {
            '/usr/share/dict/words',
        },
    }
end

return M
