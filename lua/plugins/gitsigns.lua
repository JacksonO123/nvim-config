return {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
        require("gitsigns").setup({
            signcolumn = true
        })
    end
}
