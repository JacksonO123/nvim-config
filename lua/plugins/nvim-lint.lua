return {
    "esmuellert/nvim-eslint",
    lazy = true,
    event = "VeryLazy",
    config = function()
        require("nvim-eslint").setup({
            settings = {
                workingDirectory = { mode = "location" },
                run = "onType",
                format = false,
                codeActionOnSave = {
                    enable = true,
                    mode = "all",
                },
            },
        })
    end,
}
