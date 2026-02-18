return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "mason-org/mason-registry",
            "rshkarin/mason-nvim-lint",
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

            for _, client in ipairs(clients) do
                local ok, config = pcall(require, "lsp." .. client)
                if ok then
                    vim.lsp.config(client, config)
                end
            end

            vim.lsp.enable(clients)
        end,
    },
}
