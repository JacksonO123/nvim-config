return {
    {
        "davidmh/cspell.nvim",
    },
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls");
            local cspell = require("cspell");

            null_ls.setup({
                sources = {
                    cspell.diagnostics.with({
                        diagnostics_postprocess = function(diagnostic)
                            diagnostic.severity = vim.diagnostic.severity.WARN
                        end
                    }),
                    cspell.code_actions
                }
            })

            vim.keymap.set("n", "<leader>la", function()
                vim.lsp.buf.code_action()
            end)
        end
    }
}
