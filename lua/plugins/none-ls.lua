return {
    {
        "davidmh/cspell.nvim",
    },
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local cspell = require("cspell")

            local cspellConfig = {
                find_json = function(_)
                    return os.getenv("HOME") .. "/cspell.json"
                end,
            }

            null_ls.setup({
                sources = {
                    cspell.diagnostics.with({
                        diagnostics_postprocess = function(diagnostic)
                            diagnostic.severity = vim.diagnostic.severity.WARN
                        end,
                        config = cspellConfig,
                    }),
                    cspell.code_actions.with({
                        config = cspellConfig,
                    }),
                },
            })

            vim.keymap.set("n", "<leader>la", function()
                vim.lsp.buf.code_action()
            end)
        end,
    },
}
