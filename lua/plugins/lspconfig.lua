return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local clients = require("config.settings").lsp_clients

            require("mason").setup()
            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = clients,
            })

            vim.lsp.config("*", {})
            vim.lsp.config("null-ls", {})

            vim.lsp.enable(clients)

            -- lsp borders
            local border_style = "rounded"
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border_style })
            vim.lsp.handlers["textDocument/signatureHelp"] =
                vim.lsp.with(vim.lsp.handlers.signature_help, { border = border_style })
            vim.diagnostic.config({
                virtual_text = true,
                float = { border = border_style },
            })

            require("lspconfig.ui.windows").default_options = {
                border = border_style,
            }

            vim.api.nvim_win_set_option(
                vim.api.nvim_get_current_win(),
                "winhighlight",
                "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None"
            )

            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = "rounded"
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end
        end,
    },
}
