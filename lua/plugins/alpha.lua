return {
    "goolord/alpha-nvim",
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Set header
        dashboard.section.header.val = {
            "                                                     ",
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            "                                                     ",
        }

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("f", "   Find file", ":Telescope find_files<CR>"),
            dashboard.button("n", "   New file", "<CMD>ene!<CR>"),
            dashboard.button("t", "󱄽   Search text", ":Telescope live_grep<CR>"),
            dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
            dashboard.button("c", "   Config",
                "<CMD>cd $HOME/.config/nvim/<CR><CMD>edit $HOME/.config/nvim/init.lua<CR>"),
            dashboard.button("q", "   Quit NVIM", ":qa<CR>"),
        }

        alpha.setup(dashboard.opts)

        -- Disable folding on alpha buffer
        vim.cmd([[
        autocmd FileType alpha setlocal nofoldenable
    ]])
    end,
}
