local M = {}

local icons = require("lua.defs.icons")
M.icons = icons

M.map_leader = " "
M.map_local_leader = "\\"

-- M.format_on_save = true
M.format_on_save = false

M.tab_width = 2;

M.transparent = true
M.colorscheme = "kanagawa-paper"

M.formatter_ft = {
    prettierd = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "json",
        "css",
        "scss",
        "markdown",
        "html"
    },
    isort = { "python" },
    black = { "python" },
    styleua = { "lua" },
    beautysh = { "bash" },
    rustfmt = { "rust" },
    yamlfix = { "yaml" },
    taplo = { "toml" },
}

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
