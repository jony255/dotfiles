local M = {}

function M.setup()
    require("cmp_dictionary").setup {
        dic = {
            ["*"] = { "/usr/share/dict/words" },
        },

        exact = 2,
        first_case_insensitive = false,
        async = true,
        capacity = 5,
        debug = false,
    }
end

return M
