return {
    {
        "mfussenegger/nvim-lint",
        lazy = true,
        event = "VeryLazy",
    },
    {
        "esmuellert/nvim-eslint",
        lazy = true,
        event = "VeryLazy",
        config = function()
            local settings = require("config.settings");

            require("nvim-eslint").setup({
                settings = {
                    workingDirectory = { mode = "location" },
                    run = "onType",
                    format = settings.format_on_save,
                    codeActionOnSave = {
                        enable = true,
                        mode = "all",
                    },
                },
            })
        end,
    },
}
