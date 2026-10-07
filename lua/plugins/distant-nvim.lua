return {
    'chipsenkbeil/distant.nvim',
    branch = 'v0.3',
    lazy = true,
    event = "VeryLazy",
    config = function()
        require('distant'):setup()

        vim.schedule(function()
            vim.diagnostic.config({ underline = true, signs = true, virtual_text = false })
        end)
    end
}
