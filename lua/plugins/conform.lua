return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local settings = require("config.settings")

        require("conform").setup({
            formatters_by_ft = settings.formatter_ft,
            default_format_opts = settings.format_ops,
            format_on_save = settings.format_on_save and {} or nil,
        })
    end,
}
