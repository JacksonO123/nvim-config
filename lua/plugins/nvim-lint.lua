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
                root_dir = function(bufname)
                    local root_markers = {
                        ".git",
                        "eslint.config.js",
                        "eslint.config.mjs",
                        "eslint.config.cjs",
                        "eslint.config.ts",
                        "eslint.config.mts",
                        "eslint.config.cts",
                        ".eslintrc.js",
                        ".eslintrc.cjs",
                        ".eslintrc.yaml",
                        ".eslintrc.yml",
                        ".eslintrc.json",
                        ".eslintrc",
                    }

                    local found = vim.fs.find(root_markers, {
                        upward = true,
                        path = vim.fs.dirname(bufname)
                    })

                    if found[1] then
                        return vim.fs.dirname(found[1])
                    end

                    return nil
                end,
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
