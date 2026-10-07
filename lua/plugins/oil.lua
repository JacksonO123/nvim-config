return {
    "stevearc/oil.nvim",
    lazy = true,
    cmd = "Oil",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            default_file_explorer = false,
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false,
            },
        })
    end,
}
