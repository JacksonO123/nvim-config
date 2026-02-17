return {
    "nvim-lualine/lualine.nvim",
    config = function()
        vim.cmd("hi StatusLine guibg=NONE")
        vim.cmd("hi StatusLineNC guibg=NONE")

        local custom_theme = require('lualine.themes.auto')

        custom_theme.normal.c.bg = "NONE"
        custom_theme.insert.c.bg = "NONE"
        custom_theme.replace.c.bg = "NONE"
        custom_theme.visual.c.bg = "NONE"
        custom_theme.command.c.bg = "NONE"
        custom_theme.inactive.c.bg = "NONE"
        custom_theme.terminal.c.bg = "NONE"

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
