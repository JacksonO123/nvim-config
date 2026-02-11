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
            require("nvim-eslint").setup {
                settings = {
                    workingDirectory = { mode = "location" },
                    run = "onType",
                    codeActionOnSave = {
                        enable = true,
                        mode = "all", -- Apply all fixes on save
                    },
                },
            }
        end
    },
}
