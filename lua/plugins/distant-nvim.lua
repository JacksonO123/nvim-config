return {
    'chipsenkbeil/distant.nvim',
    branch = 'v0.3',
    lazy = true,
    event = "VeryLazy",
    config = function()
        require('distant'):setup()

        -- distant nvim bug chipsenkbeil/distant.nvim#125 globally disables diagnostic underlines.
        -- so, re-enable them
        vim.schedule(function()
            vim.diagnostic.config({ underline = true, signs = true })
        end)
    end
}
