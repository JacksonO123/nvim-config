local M = {}

M.colorschemes = {
    {
        "thesimonho/kanagawa-paper.nvim",
        name = "kanagawa-paper",
        config = function()
            require("kanagawa-paper").setup({
                transparent = true,
                colors = {
                    palette = {
                        sumiInk6 = "#828282",
                    },
                },
            })
        end,
    },

    {
        -- https://github.com/marko-cerovac/material.nvim
        "marko-cerovac/material.nvim",
        name = "material",
        config = function()
            require("material").setup({
                disable = {
                    background = true,
                },
            })
        end
    },

    {
        -- https://github.com/sainnhe/sonokai
        "sainnhe/sonokai",
        name = "sonokai",
        config = function()
            vim.g.sonokai_transparent_background = 2
        end
    },

    {
        -- https://github.com/shaunsingh/nord.nvim
        "shaunsingh/nord.nvim",
        name = "nord",
        config = function()
            vim.g.nord_disable_background = true
        end
    },

    {
        -- https://github.com/catppuccin/nvim
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
            })
        end
    },

    {
        -- https://github.com/rmehri01/onenord.nvim
        "rmehri01/onenord.nvim",
        name = "onenord",
        config = function()
            require("onenord").setup({
                disable = {
                    background = true,
                },
            })
        end
    },

    {
        -- https://github.com/rebelot/kanagawa.nvim?tab=readme-ov-file
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        config = function()
            require("kanagawa").setup({
                transparent = true,
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none"
                            }
                        }
                    }
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },

                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    }
                end,
            })
        end
    },

    {
        -- https://github.com/killitar/obscure.nvim
        "killitar/obscure.nvim",
        name = "obscure",
        config = function()
            require("obscure").setup({
                transparent = true,
            })
        end
    }
}

return M
