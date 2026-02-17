return {
    "nvim-lualine/lualine.nvim",
    config = function()
        vim.cmd("hi StatusLine guibg=NONE")
        vim.cmd("hi StatusLineNC guibg=NONE")

        local custom_theme = require("lualine.themes.iceberg_dark")

        custom_theme.visual = {
            a = custom_theme.visual.a,
            b = custom_theme.visual.b,
            c = "NONE",
        }
        custom_theme.replace = {
            a = custom_theme.replace.a,
            b = custom_theme.replace.b,
            c = "NONE",
        }
        custom_theme.inactive = {
            a = custom_theme.inactive.a,
            b = custom_theme.inactive.b,
            c = "NONE",
        }
        custom_theme.normal = {
            a = custom_theme.normal.a,
            b = custom_theme.normal.b,
            c = "NONE",
        }
        custom_theme.insert = {
            a = custom_theme.insert.a,
            b = custom_theme.insert.b,
            c = "NONE",
        }

        require('lualine').setup({
            options = {
                theme = custom_theme,
            },
            sections = {
                lualine_x = {
                    'encoding',
                    'filetype',
                },
            },
        })
    end
}
