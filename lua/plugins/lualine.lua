return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local settings = require("config.settings")

        if settings.transparentLuaLine then
            vim.cmd("hi StatusLine guibg=NONE")
            vim.cmd("hi StatusLineNC guibg=NONE")
        end

        local custom_theme = require("lualine.themes.iceberg_dark")

        if settings.transparentLuaLine then
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
        end

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
