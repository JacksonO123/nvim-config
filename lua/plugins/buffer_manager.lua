return {
    "j-morano/buffer_manager.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    event = "VeryLazy",
    config = function()
        local bm = require("buffer_manager")

        bm.setup({})

        vim.keymap.set("n", "<leader>bm", function()
            require("buffer_manager.ui").toggle_quick_menu()
        end, { noremap = true, silent = true })
    end
}
