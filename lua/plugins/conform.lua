return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local settings = require("config.settings")

        if settings.format_on_save then
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = settings.formatter_ft,
                format_on_save = function()
                    return {
                        timeout_ms = 1500,
                        lsp_fallback = true,
                    }
                end
            })
        end
    end
}
