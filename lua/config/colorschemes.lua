local M = {}

local settings = require("config.settings")

M.colorschemes = {
    {
        "thesimonho/kanagawa-paper.nvim",
        name = "kanagawa-paper",
        config = function()
            require("kanagawa-paper").setup({
                transparent = settings.transparent,
                colors = {
                    palette = {
                        sumiInk6 = "#828282",
                    },
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        Pmenu = { fg = theme.ui.fg, bg = "NONE" },
                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },

                        FloatBorder = { fg = theme.ui.fg_dim, bg = "NONE" },
                        NormalFloat = { fg = theme.ui.fg, bg = "NONE" },

                        CmpItemAbbrMatch = { fg = theme.diag.hint, bold = true },
                        CmpItemAbbrMatchFuzzy = { fg = theme.diag.hint, bold = true },
                        CmpItemMenu = { fg = theme.ui.fg_dim, italic = true },
                    }
                end
            })
        end,
    },

    {
        -- https://github.com/sainnhe/sonokai
        "sainnhe/sonokai",
        name = "sonokai",
        config = function()
            if settings.transparent then
                vim.g.sonokai_transparent_background = 2
            end
        end,
    },

    {
        -- https://github.com/shaunsingh/nord.nvim
        "shaunsingh/nord.nvim",
        name = "nord",
        config = function()
            vim.g.nord_disable_background = settings.transparent
        end,
    },

    {
        -- https://github.com/catppuccin/nvim
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                transparent_background = settings.transparent,
            })
        end,
    },

    {
        -- https://github.com/rmehri01/onenord.nvim
        "rmehri01/onenord.nvim",
        name = "onenord",
        config = function()
            require("onenord").setup({
                disable = {
                    background = settings.transparent,
                },
            })
        end,
    },

    {
        -- https://github.com/rebelot/kanagawa.nvim?tab=readme-ov-file
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        config = function()
            require("kanagawa").setup({
                transparent = settings.transparent,
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none",
                            },
                        },
                    },
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    }
                end,
            })
        end,
    },

    {
        -- https://github.com/killitar/obscure.nvim
        "killitar/obscure.nvim",
        name = "obscure",
        config = function()
            require("obscure").setup({
                transparent = settings.transparent,
            })
        end,
    },
}

return M
