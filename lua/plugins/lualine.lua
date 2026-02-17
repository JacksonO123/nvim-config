return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local custom_theme = require('lualine.themes.auto')
        custom_theme.normal.c.bg = 'None'
        custom_theme.inactive.c.bg = 'None'

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

        vim.cmd("hi StatusLine guibg=NONE")
    end
}
