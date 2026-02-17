local M = {}

M.format_ops = {
    lsp_format = "fallback",
    timeout_ms = 500,
}

local formatter_ft_to_conform = function(formatter_ft)
    local res = {}

    for key, value in pairs(formatter_ft) do
        for i = 1, #value do
            res[value[i]] = { key }
        end
    end

    return res
end

local formatter_ft = require("lua.config.settings").formatter_ft
M.formatter_by_ft = formatter_ft_to_conform(formatter_ft)

return M
