return {
    "akinsho/git-conflict.nvim",
    version = "*",
    lazy = true,
    event = "VeryLazy",
    config = function()
        local set_decoration_provider = vim.api.nvim_set_decoration_provider
        vim.api.nvim_set_decoration_provider = function(ns, opts)
            local on_win = opts.on_win
            if on_win then
                opts.on_win = function(name, winid, bufnr, ...)
                    if bufnr == vim.api.nvim_get_current_buf() then
                        return on_win(name, winid, bufnr, ...)
                    end
                end
            end
            return set_decoration_provider(ns, opts)
        end

        local ok, err = pcall(require("git-conflict").setup)
        vim.api.nvim_set_decoration_provider = set_decoration_provider
        if not ok then
            error(err)
        end
    end,
}
