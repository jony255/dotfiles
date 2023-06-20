local M = {}

local cmp_dictionary = require('cmp_dictionary')

function M.setup()
    cmp_dictionary.setup {
        exact = 2,
        first_case_insensitive = true,
        async = true,
        capacity = 5,
        debug = false,
    }

    cmp_dictionary.switcher {
        spelllang = {
            en = '/usr/share/dict/words',
        },
    }
end

return M
