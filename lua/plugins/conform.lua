local function get_formatter()
    local settings = require("config.settings")
    local formatters_out = {}

    for key, value in pairs(settings.formatter_ft) do
        if type(value) == "function" then
            formatters_out[key] = value()
        else
            formatters_out[key] = value
        end
    end

    return formatters_out
end

return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local settings = require("config.settings")

        require("conform").setup({
            formatters_by_ft = {
                javascript = get_formatter,
                typescript = get_formatter,
                javascriptreact = get_formatter,
                typescriptreact = get_formatter,
                json = get_formatter,
                css = get_formatter,
                scss = get_formatter,
                markdown = get_formatter,
                html = get_formatter,
            },
            format_on_save = settings.format_on_save and settings.format_ops or nil,
        })
    end,
}
