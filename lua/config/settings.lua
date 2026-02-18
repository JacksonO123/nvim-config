local M = {}

local icons = require("defs.icons")
M.icons = icons

M.map_leader = " "
M.map_local_leader = "\\"

M.format_on_save = true
-- M.format_on_save = false

M.tab_width = 2

M.transparent = true
M.colorscheme = "kanagawa-paper"

M.formatter_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    markdown = { "prettier" },
    html = { "prettier" },

    python = { "isort", "black" },
    bash = { "beautysh" },
    rust = { "rustfmt" },
    yaml = { "yamlfix" },
    toml = { "taplo" },
}

M.format_ops = {
    lsp_format = "fallback",
    timeout_ms = 500,
}

M.lsp_clients = {
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
    "eslint",
}

return M
