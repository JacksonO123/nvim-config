return {
    { "JoosepAlviste/nvim-ts-context-commentstring", },
    {
        "nvim-treesitter/playground",
        lazy = true,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            local ts = require("nvim-treesitter")

            ts.auto_install = true

            ts.setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            ts.install({
                "javascript",
                "typescript",
                "tsx",
                "bash",
                "c",
                "css",
                "go",
                "html",
                "make",
                "json",
                "python",
                "regex",
                "rust",
                "sql",
                "zig",
                "lua"
            }, false)

            local context_commentstring = require("ts_context_commentstring")
            context_commentstring.setup()

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype) or vim.bo[args.buf]
                        .filetype
                    if lang then
                        pcall(vim.treesitter.start, args.buf, lang)
                    end
                end
            })
        end
    },
}
