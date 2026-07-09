return {
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = { "VeryLazy" },
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
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
            local settings = require("config.settings")
            local mason_clients = settings.mason_lsp_clients
            local bin_clients = settings.bin_lsp_clients

            local all_clients = {}
            vim.list_extend(all_clients, mason_clients)
            vim.list_extend(all_clients, bin_clients)

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = mason_clients,
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = false

            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            for _, client in ipairs(all_clients) do
                local ok, config = pcall(require, "lsp." .. client)
                if ok then
                    vim.lsp.config(client, config)
                end
            end

            vim.lsp.enable(all_clients)
        end,
    },
}
