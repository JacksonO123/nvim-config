return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local formatter_utils = require("utils.formatter")
        local conform = require("conform")
        local formatter_by_ft = require("utils.formatter").formatter_by_ft

        conform.setup({
            formatters_by_ft = formatter_by_ft,
            format_on_save = function()
                return {
                    timeout_ms = 1500,
                    lsp_fallback = true,
                }
            end
        })

        local settings = require("config.settings")

        if settings.format_on_save then
            local format_augroup = vim.api.nvim_create_augroup("format", { clear = true })

            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                group = format_augroup,
                callback = function()
                    conform.format(formatter_utils.format_ops)
                end
            })
        end
    end
}
