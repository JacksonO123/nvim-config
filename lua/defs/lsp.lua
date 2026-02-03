local M = {}

-- list of lspconfig supported lsp clients
-- https://github.com/neovim/nvim-lspconfig

M.clients = {
    "lua_ls",
    "ts_ls",
    "clangd",
    "zls",
    "rust_analyzer",
    "jsonls",
    "bashls",
    "tailwindcss",
    "pyright",
    "cssls",
    "jdtls",
    "eslint"
}

return M
